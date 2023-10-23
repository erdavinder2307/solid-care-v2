import 'package:flutter/material.dart';
import 'package:solidcare/model/qualification_model.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/extensions/string_extensions.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class QualificationItemWidget extends StatelessWidget {
  final Qualification data;
  final Function() onEdit;

  const QualificationItemWidget(
      {Key? key, required this.data, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: context.cardColor),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ic_graduation_cap.iconImage(size: 24, color: appSecondaryColor),
              16.width,
              Text(data.degree.validate().toUpperCase(),
                      style: boldTextStyle(size: 16))
                  .expand(),
              ic_edit
                  .iconImage(
                      size: 22, color: context.iconColor, fit: BoxFit.cover)
                  .onTap(onEdit)
            ],
          ),
          2.height,
          Row(
            children: [
              if (data.university.validate().isNotEmpty)
                Text(data.university.validate(), style: secondaryTextStyle()),
              if (data.year.toString().isNotEmpty)
                Text(" - ${data.year.toString().validate()}",
                    style: secondaryTextStyle()),
            ],
          ).paddingOnly(left: 40),
        ],
      ),
    );
  }
}
