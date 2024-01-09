import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:solidcare/components/app_setting_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/screens/doctor/screens/holiday/holiday_list_screen.dart';
import 'package:solidcare/screens/doctor/screens/service/service_list_screen.dart';
import 'package:solidcare/screens/doctor/screens/sessions/doctor_session_list_screen.dart';
import 'package:solidcare/screens/encounter/screen/encounter_list_screen.dart';
import 'package:solidcare/screens/patient/screens/my_bill_records_screen.dart';
import 'package:solidcare/screens/patient/screens/review/rating_view_all_screen.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class DoctorReceptionistGeneralSettingComponent extends StatelessWidget {
  const DoctorReceptionistGeneralSettingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 16,
        runSpacing: 16,
        children: [
          if (isVisible(SharedPreferenceKey.solidCareServiceListKey))
            AppSettingWidget(
              name: locale.lblServices,
              image: ic_services,
              widget: ServiceListScreen(),
              subTitle: locale.lblServicesYouProvide,
            ),
          if (isVisible(SharedPreferenceKey.solidCareClinicScheduleKey))
            AppSettingWidget(
              name: locale.lblHoliday,
              image: ic_holiday,
              widget: HolidayScreen(),
              subTitle: locale.lblScheduledHolidays,
            ),
          if (isVisible(SharedPreferenceKey.solidCareDoctorSessionListKey))
            AppSettingWidget(
              name: locale.lblSessions,
              image: ic_calendar,
              widget: DoctorSessionListScreen(),
              subTitle: locale.lblAvailableSession,
            ),
          if (isVisible(SharedPreferenceKey.solidCarePatientEncounterListKey))
            AppSettingWidget(
              name: locale.lblEncounters,
              image: ic_services,
              widget: EncounterListScreen(),
              subTitle: locale.lblYourAllEncounters,
            ),
          if (isProEnabled() &&
              isVisible(SharedPreferenceKey.solidCarePatientBillListKey))
            AppSettingWidget(
              name: locale.lblBillingRecords,
              image: ic_bill,
              widget: MyBillRecordsScreen(),
              subTitle: locale.lblGetYourAllBillsHere,
            ),
          if (isProEnabled() &&
              isDoctor() &&
              isVisible(SharedPreferenceKey.solidCarePatientReviewGetKey))
            AppSettingWidget(
              name: locale.lblRatingsAndReviews,
              image: ic_rateUs,
              widget:
                  RatingViewAllScreen(doctorId: userStore.userId.validate()),
              subTitle: locale.lblWhatYourCustomersSaysAboutYou,
            ),
        ],
      );
    });
  }
}
