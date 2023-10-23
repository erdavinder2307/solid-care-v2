import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solidcare/components/status_widget.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:solidcare/components/image_border_component.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/holiday_model.dart';
import 'package:solidcare/utils/common.dart';

class HolidayWidget extends StatelessWidget {
  final HolidayData data;

  HolidayWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    int totalDays = getDateDifference(data.holidayStartDate.validate(),
        eDate: data.holidayEndDate.validate(), isForHolidays: true);
    int pendingDays = getDateDifference(data.holidayStartDate.validate());
    List<DateTime> dates = getDatesBetweenTwoDates(
        DateFormat(SAVE_DATE_FORMAT).parse(data.holidayStartDate.validate()),
        DateFormat(SAVE_DATE_FORMAT).parse(data.holidayEndDate.validate()));

    String today = DateFormat(SAVE_DATE_FORMAT).format(DateTime.now());
    bool isPending = getDateDifference(data.holidayEndDate.validate()) < 0;
    bool isOnLeave = dates
        .map((date) => DateFormat(SAVE_DATE_FORMAT).format(date))
        .contains(today);

    return Container(
      width: context.width() / 2 - 24,
      decoration: boxDecorationDefault(
          borderRadius: radius(),
          color: context.cardColor,
          border: Border.all(color: context.dividerColor)),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.userProfileImage.validate().isNotEmpty)
                        ImageBorder(
                            src: data.userProfileImage.validate(), height: 34)
                      else
                        GradientBorder(
                          gradient: LinearGradient(
                              colors: [primaryColor, appSecondaryColor],
                              tileMode: TileMode.mirror),
                          strokeWidth: 2,
                          borderRadius: 80,
                          child: PlaceHolderWidget(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            shape: BoxShape.circle,
                            child: Text(
                                isDoctor()
                                    ? data.userName
                                        .validate(value: 'D')[0]
                                        .capitalizeFirstLetter()
                                    : data.userName
                                        .validate(value: 'C')[0]
                                        .capitalizeFirstLetter(),
                                style: boldTextStyle(size: 16)),
                          ),
                        ),
                      8.width,
                      Marquee(
                        child: Text(
                            isDoctor()
                                ? data.userName
                                    .validate()
                                    .prefixText(value: 'Dr. ')
                                : data.userName.validate(),
                            style: boldTextStyle(size: 16)),
                      ).expand(),
                    ],
                  ),
                  8.height,
                  Text('${data.startDate.validate()}',
                      style: primaryTextStyle(size: 14)),
                  Text('—', style: primaryTextStyle()),
                  Text('${data.endDate.validate()}',
                      style: primaryTextStyle(size: 14)),
                  10.height,
                  if (isOnLeave)
                    Text(
                        data.userName.split(' ').first.validate() +
                            " " +
                            locale.lblIsOnLeave,
                        style: boldTextStyle(size: 14, color: appPrimaryColor))
                  else
                    Text(
                            locale.lblAfter +
                                ' ${pendingDays == 0 ? '1' : pendingDays.abs()} ' +
                                locale.lblDays,
                            style: boldTextStyle(size: 14))
                        .visible(isPending),
                  if (!isOnLeave)
                    Text(
                      locale.lblWasOffFor +
                          ' ${totalDays == 0 ? '1' : totalDays} ' +
                          locale.lblDays,
                      style: boldTextStyle(size: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).visible(!isPending),
                ],
              ).expand(),
            ],
          ).paddingAll(16),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: StatusWidget(
              status: '',
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              borderRadius:
                  radiusOnly(topLeft: defaultRadius, bottomLeft: defaultRadius),
              backgroundColor:
                  getHolidayStatusColor(isPending, isOnLeave).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
