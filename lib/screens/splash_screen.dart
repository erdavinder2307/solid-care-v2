import 'package:flutter/material.dart';
import 'package:solidcare/components/app_logo.dart';
import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/screens/auth/screens/sign_in_screen.dart';
import 'package:solidcare/screens/doctor/doctor_dashboard_screen.dart';
import 'package:solidcare/screens/patient/p_dashboard_screen.dart';
import 'package:solidcare/screens/receptionist/r_dashboard_screen.dart';
import 'package:solidcare/screens/walkThrough/walk_through_screen.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
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

    if (!getBoolAsync(IS_WALKTHROUGH_FIRST, defaultValue: false)) {
      WalkThroughScreen()
          .launch(context, isNewTask: true); // User is for first time.
    } else if (appStore.isLoggedIn && isDoctor()) {
      DoctorDashboardScreen()
          .launch(context, isNewTask: true); // User is Doctor
    } else if (appStore.isLoggedIn && isPatient()) {
      PatientDashBoardScreen()
          .launch(context, isNewTask: true); // User is Patient
    } else if (appStore.isLoggedIn && isReceptionist()) {
      RDashBoardScreen()
          .launch(context, isNewTask: true); // User is Receptionist
    } else {
      SignInScreen().launch(context, isNewTask: true);
    }
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
