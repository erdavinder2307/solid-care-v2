import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/dashboard_model.dart';
import 'package:solidcare/screens/doctor/components/dashboard_count_widget.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardFragmentAnalyticsComponent extends StatelessWidget {
  final DashboardModel data;
  DashboardFragmentAnalyticsComponent({required this.data});

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [
      if ((isDoctor() &&
              isVisible(SharedPreferenceKey
                  .solidCareDashboardTotalTodayAppointmentKey)) ||
          (isReceptionist() &&
              isVisible(SharedPreferenceKey.solidCareDashboardTotalDoctorKey)))
        DashBoardCountWidget(
          title: isReceptionist()
              ? locale.lblTotalDoctors
              : locale.lblTodayAppointments,
          color1: appSecondaryColor,
          count: isReceptionist()
              ? data.totalDoctor
              : data.upcomingAppointmentTotal.validate(),
          icon: FontAwesomeIcons.calendarCheck,
        ),
      if (isVisible(SharedPreferenceKey.solidCareDashboardTotalAppointmentKey))
        DashBoardCountWidget(
          title: locale.lblTotalAppointment,
          color1: appPrimaryColor,
          count: data.totalAppointment.validate(),
          icon: FontAwesomeIcons.calendarCheck,
        ),
      if (isVisible(SharedPreferenceKey.solidCareDashboardTotalPatientKey))
        DashBoardCountWidget(
          title: locale.lblTotalPatient,
          color1: appSecondaryColor,
          count: data.totalPatient.validate(),
          icon: FontAwesomeIcons.userInjured,
        )
    ];
    return Wrap(
      spacing: 14,
      crossAxisAlignment: child.length > 2
          ? WrapCrossAlignment.start
          : WrapCrossAlignment.center,
      children: child.map((e) => e).toList(),
    ).paddingTop(16);
  }
}
