import 'package:flutter/material.dart';
import 'package:solidcare/components/no_data_found_widget.dart';
import 'package:solidcare/components/view_all_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/screens/dashboard/fragments/doctor_list_fragment.dart';
import 'package:solidcare/screens/receptionist/screens/doctor/component/doctor_list_component.dart';
import 'package:solidcare/screens/receptionist/screens/doctor/doctor_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class DashBoardFragmentTopDoctorComponent extends StatelessWidget {
  final List<UserModel> doctorList;

  DashBoardFragmentTopDoctorComponent({required this.doctorList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllLabel(
          label: locale.lblTopDoctors,
          list: doctorList.validate(),
          viewAllShowLimit: 3,
          onTap: () => DoctorListFragment().launch(context,
              pageRouteAnimation: pageAnimation,
              duration: pageAnimationDuration),
        ),
        if (doctorList.isNotEmpty) 4.height,
        if (doctorList.isNotEmpty)
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: doctorList
                .map((data) {
                  return GestureDetector(
                    onTap: () {
                      DoctorDetailScreen(doctorData: data).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade,
                          duration: 800.milliseconds);
                    },
                    child: DoctorListComponent(data: data),
                  );
                })
                .take(2)
                .toList(),
          ).visible(doctorList.isNotEmpty,
              defaultWidget:
                  NoDataFoundWidget(text: locale.lblNoDataFound, iconSize: 60)
                      .center()),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
