import 'package:flutter/material.dart';
import 'package:solidcare/components/app_logo.dart';
import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/network/clinic_repository.dart';
import 'package:solidcare/network/google_repository.dart';
import 'package:solidcare/screens/auth/screens/sign_in_screen.dart';
import 'package:solidcare/screens/dashboard/screens/doctor_dashboard_screen.dart';
import 'package:solidcare/screens/dashboard/screens/patient_dashboard_screen.dart';
import 'package:solidcare/screens/dashboard/screens/receptionist_dashboard_screen.dart';
import 'package:solidcare/screens/walkThrough/walk_through_screen.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/one_signal_notifications.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(() {
      int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
      if (themeModeIndex == THEME_MODE_SYSTEM) {
        appStore.setDarkMode(
            MediaQuery.of(context).platformBrightness == Brightness.dark);
      }
      setStatusBarColor(
        appStore.isDarkModeOn
            ? context.scaffoldBackgroundColor
            : appPrimaryColor.withOpacity(0.02),
        statusBarIconBrightness:
            appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      );
    });

    await 2.seconds.delay;
    initializeOneSignal();

    if (!getBoolAsync(IS_WALKTHROUGH_FIRST, defaultValue: false)) {
      WalkThroughScreen().launch(context,
          isNewTask: true,
          pageRouteAnimation: pageAnimation,
          duration: pageAnimationDuration); // User is for first time.
    } else {
      if (appStore.isLoggedIn) {
        getConfigurationAPI().whenComplete(() {
          if (isReceptionist() || isPatient()) {
            getSelectedClinicAPI(
                    clinicId: userStore.userClinicId.validate(),
                    isForLogin: true)
                .then((value) {
              userStore.setUserClinicImage(value.profileImage.validate(),
                  initialize: true);
              userStore.setUserClinicName(value.name.validate(),
                  initialize: true);
              userStore.setUserClinicStatus(value.status.validate(),
                  initialize: true);

              String clinicAddress = '';

              if (value.city.validate().isNotEmpty) {
                clinicAddress = value.city.validate();
              }
              if (value.country.validate().isNotEmpty) {
                clinicAddress += ' ,' + value.country.validate();
              }
              userStore.setUserClinic(value);
              userStore.userClinic?.address = clinicAddress;
              userStore.setUserClinicAddress(clinicAddress, initialize: true);
            }).catchError((r) {
              appStore.setLoading(false);
              throw r;
            });
          }
          if (isDoctor()) {
            userStore.setOneSignalTag(
                ConstantKeys.appTypeKey, ConstantKeys.doctorAppKey);
            DoctorDashboardScreen().launch(context,
                isNewTask: true,
                pageRouteAnimation: pageAnimation,
                duration: pageAnimationDuration); // User is Doctor
          } else if (isPatient()) {
            userStore.setOneSignalTag(
                ConstantKeys.appTypeKey, ConstantKeys.patientAppKey);
            PatientDashBoardScreen().launch(context,
                isNewTask: true,
                pageRouteAnimation: pageAnimation,
                duration: pageAnimationDuration); // User is Patient
          } else {
            userStore.setOneSignalTag(
                ConstantKeys.appTypeKey, ConstantKeys.receptionistAppKey);
            RDashBoardScreen().launch(context,
                isNewTask: true,
                pageRouteAnimation: pageAnimation,
                duration: pageAnimationDuration); // User is Receptionist
          }
        }).catchError((r) {
          appStore.setLoading(false);

          throw r;
        });
      } else {
        SignInScreen().launch(context,
            isNewTask: true,
            pageRouteAnimation: pageAnimation,
            duration: pageAnimationDuration);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppLogo(size: 125).center(),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text('v ${packageInfo.versionName.validate()}',
                    style: secondaryTextStyle(size: 16),
                    textAlign: TextAlign.center),
                8.height,
                Text(COPY_RIGHT_TEXT,
                    style: secondaryTextStyle(size: 12),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
