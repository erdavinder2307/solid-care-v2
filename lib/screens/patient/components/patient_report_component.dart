import 'package:flutter/material.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/report_model.dart';
import 'package:solidcare/utils/extensions/string_extensions.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:solidcare/utils/common.dart';

class PatientReportComponent extends StatelessWidget {
  final List<ReportData> reportList;

  PatientReportComponent({required this.reportList});

  @override
  Widget build(BuildContext context) {
    if (reportList.isEmpty)
      return NoDataWidget(
          title: locale.lblNoReportsFound,
          titleTextStyle: primaryTextStyle(color: Colors.red));
    return AnimatedWrap(
        runSpacing: 16,
        spacing: 16,
        listAnimationType: listAnimationType,
        itemCount: reportList.length,
        children: reportList
            .map(
              (reportData) => GestureDetector(
                onTap: () {
                  commonLaunchUrl(reportData.uploadReport.validate(),
                      launchMode: LaunchMode.externalApplication);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: context.width() / 4 - 20,
                  decoration: boxDecorationDefault(color: context.cardColor),
                  child: Column(
                    children: [
                      if (reportData.uploadReport != null)
                        Image.asset(
                          width: 60,
                          height: 60,
                          reportData.uploadReport.validate().fileFormatImage(),
                        )
                      else
                        Image.asset(
                          ic_invalidURL,
                          width: 60,
                          height: 60,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      6.height,
                      Text(reportData.name.validate(),
                          style: primaryTextStyle(size: 12)),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}
