import 'package:flutter/material.dart';
import 'package:solidcare/components/app_setting_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/screens/encounter/screen/encounter_list_screen.dart';
import 'package:solidcare/screens/patient/screens/my_bill_records_screen.dart';
import 'package:solidcare/screens/patient/screens/my_report_screen.dart';
import 'package:solidcare/screens/patient/screens/patient_clinic_selection_screen.dart';
import 'package:solidcare/utils/images.dart';

class GeneralSettingComponent extends StatelessWidget {
  final VoidCallback? callBack;
  GeneralSettingComponent({this.callBack});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 16,
      runSpacing: 16,
      children: [
        AppSettingWidget(
          name: locale.lblEncounters,
          image: ic_services,
          widget: EncounterListScreen(),
          subTitle: locale.lblYourEncounters,
        ),
        AppSettingWidget(
          name: locale.lblMedicalReports,
          image: ic_reports,
          widget: MyReportsScreen(),
          subTitle: locale.lblYourReports,
        ),
        AppSettingWidget(
          name: locale.lblBillingRecords,
          image: ic_bill,
          widget: MyBillRecordsScreen(),
          subTitle: locale.lblYourBills,
        ),
        AppSettingWidget(
          name: locale.lblChangeYourClinic,
          image: ic_clinic,
          widget: PatientClinicSelectionScreen(callback: () {
            callBack?.call();
          }),
          subTitle: locale.lblChooseYourFavouriteClinic,
        ),
      ],
    );
  }
}
