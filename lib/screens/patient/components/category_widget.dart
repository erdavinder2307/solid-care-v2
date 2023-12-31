import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solidcare/components/cached_image_widget../../../model/service_model.dart';
import 'package:solidcare/components/image_border_component.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryWidget extends StatelessWidget {
  final ServiceData data;

  final bool hideMoreButton;

  CategoryWidget({Key? key, required this.data, this.hideMoreButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: context.width() / 2 - 24,
      decoration: data.image.validate().isNotEmpty
          ? boxDecorationDefault(
              color: context.cardColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.multiply),
                image: NetworkImage(
                  data.image.validate(),
                ),
              ),
            )
          : BoxDecoration(
              color: lightColors[Random.secure().nextInt(lightColors.length)],
              shape: BoxShape.rectangle,
              borderRadius: radius(),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name.validate().capitalizeEachWord(),
            textAlign: TextAlign.start,
            style: boldTextStyle(
                size: 14,
                color: data.image.validate().isNotEmpty
                    ? Colors.white
                    : Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          8.height,
          if (data.doctorList.validate().length > 0)
            Text(
              '${data.doctorList.validate().length} ${(data.doctorList.validate().length > 1) ? locale.lblDoctorsAvailable : locale.lblDoctorAvailable}',
              style: secondaryTextStyle(
                  color: data.image.validate().isNotEmpty
                      ? Colors.white70
                      : Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          8.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children:
                    List.generate(data.doctorList.validate().length, (index) {
                  UserModel userData = data.doctorList.validate()[index];
                  if (userData.profileImage != null &&
                      userData.profileImage!.isNotEmpty)
                    return ImageBorder(
                      src: userData.profileImage.validate(),
                      height: 30,
                      width: 30,
                    ).paddingLeft(index == 0 ? 0 : (index) * 20);
                  else
                    return GradientBorder(
                      gradient: LinearGradient(
                          colors: [primaryColor, appSecondaryColor],
                          tileMode: TileMode.mirror),
                      strokeWidth: 2,
                      borderRadius: 80,
                      child: PlaceHolderWidget(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        shape: BoxShape.circle,
                        child: Text(
                            '${userData.displayName.validate(value: 'D')[0].capitalizeFirstLetter()}',
                            style: boldTextStyle(size: 18)),
                      ),
                    ).paddingLeft(index == 0 ? 0 : (index * 20));
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
