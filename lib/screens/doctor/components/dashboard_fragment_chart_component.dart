import 'package:flutter/material.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/dashboard_model.dart';
import 'package:solidcare/screens/doctor/components/weekly_chart_component.dart';
import 'package:solidcare/screens/doctor/screens/show_appointment_chart_screen.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardFragmentChartComponent extends StatelessWidget {
  final DashboardModel data;
  DashboardFragmentChartComponent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Row(
          children: [
            Text(locale.lblWeeklyAppointments,
                    style: boldTextStyle(size: titleTextSize))
                .paddingOnly(left: 10)
                .expand(),
            Text(locale.lblMore,
                    style: secondaryTextStyle(color: appSecondaryColor))
                .onTap(
              () {
                ShowAppointmentChartScreen().launch(context);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            16.width,
          ],
        ),
        10.height,
        Container(
          height: 220,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 16, right: 16, top: 24),
          decoration: boxDecorationDefault(
              borderRadius: radius(), color: context.cardColor),
          child: WeeklyChartComponent(
                  weeklyAppointment:
                      data.weeklyAppointment.validate().isNotEmpty
                          ? data.weeklyAppointment.validate()
                          : emptyGraphList)
              .withWidth(
            context.width(),
          ),
        )
      ],
    ).paddingAll(8);
  }
}
