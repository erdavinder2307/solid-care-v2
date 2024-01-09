import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:solidcare/app_theme.dart';
import 'package:solidcare/config.dart';
import 'package:solidcare/locale/app_localizations.dart';
import 'package:solidcare/locale/base_language_key.dart';
import 'package:solidcare/locale/language_en.dart';
import 'package:solidcare/model/language_model.dart';
import 'package:solidcare/network/auth_repository.dart';
import 'package:solidcare/network/services/default_firebase_config.dart';
import 'package:solidcare/screens/patient/store/patient_store.dart';
import 'package:solidcare/screens/splash_screen.dart';
import 'package:solidcare/store/AppStore.dart';
import 'package:solidcare/store/AppointmentAppStore.dart';
import 'package:solidcare/screens/doctor/store/DoctorAppStore.dart';
import 'package:solidcare/store/ListAppStore.dart';
import 'package:solidcare/store/MultiSelectStore.dart';
import 'package:solidcare/screens/receptionist/store/ReceptionistAppStore.dart';
import 'package:solidcare/store/PermissionStore.dart';
import 'package:solidcare/store/UserStore.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:workmanager/workmanager.dart';

import 'utils/app_common.dart';

late PackageInfoData packageInfo;

late StreamSubscription<ConnectivityResult> _connectivitySubscription;

AppStore appStore = AppStore();
PatientStore patientStore = PatientStore();
ListAppStore listAppStore = ListAppStore();
AppointmentAppStore appointmentAppStore = AppointmentAppStore();
MultiSelectStore multiSelectStore = MultiSelectStore();
DoctorAppStore doctorAppStore = DoctorAppStore();
ReceptionistAppStore receptionistAppStore = ReceptionistAppStore();
PermissionStore permissionStore = PermissionStore();

UserStore userStore = UserStore();
ListAnimationType listAnimationType = ListAnimationType.FadeIn;
PageRouteAnimation pageAnimation = PageRouteAnimation.Fade;

Duration pageAnimationDuration = Duration(milliseconds: 500);

List<String> paymentMethodList = [];
List<String> paymentMethodImages = [];
List<String> paymentModeList = [];

BaseLanguage locale = LanguageEn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  defaultBlurRadius = 0;
  defaultSpreadRadius = 0.0;

  defaultAppBarElevation = 2;
  appBarBackgroundColorGlobal = primaryColor;
  appButtonBackgroundColorGlobal = primaryColor;

  defaultAppButtonTextColorGlobal = Colors.white;
  defaultAppButtonElevation = 0.0;
  passwordLengthGlobal = 5;
  defaultRadius = 12;
  defaultLoaderAccentColorGlobal = primaryColor;

  await initialize(aLocaleLanguageList: languageList());

  Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions)
      .then((value) {
    setupRemoteConfig();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  });

  appStore.setLanguage(
      getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: DEFAULT_LANGUAGE));
  appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));

  await defaultValue();

  HttpOverrides.global = HttpOverridesSkipCertificate();

  packageInfo = await getPackageInfo();

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == THEME_MODE_LIGHT) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == THEME_MODE_DARK) {
    appStore.setDarkMode(true);
  }
  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // Workmanager().registerOneOffTask(
  //   "task-identifier", "simpleTaskKey", // Ignored on iOS
  //   initialDelay: Duration(minutes: 15),
  //   constraints: Constraints(
  //     // connected or metered mark the task as requiring internet
  //     networkType: NetworkType.connected,
  //   ),
  // );
  runApp(MyApp());
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      appStore.setInternetStatus(event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi);
    });
    OneSignal.initialize(ONESIGNAL_APP_ID);
    OneSignal.Notifications.requestPermission(false);

    OneSignal.Notifications.addClickListener((event) {
      log('${jsonEncode(event.notification)}');

      if (isPatient()) patientStore.setBottomNavIndex(1);
      if (isDoctor()) doctorAppStore.setBottomNavIndex(1);
      if (isReceptionist()) receptionistAppStore.setBottomNavIndex(1);
    });
    removePermission();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: APP_NAME,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        navigatorKey: navigatorKey,
        supportedLocales: Language.languagesLocale(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguageCode),
        localizationsDelegates: [
          AppLocalizations(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
