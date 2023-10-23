import 'dart:async';
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
import 'package:solidcare/model/bill_list_model.dart';
import 'package:solidcare/model/clinic_list_model.dart';
import 'package:solidcare/model/encounter_model.dart';
import 'package:solidcare/model/language_model.dart';
import 'package:solidcare/model/report_model.dart';
import 'package:solidcare/network/services/default_firebase_config.dart';
import 'package:solidcare/screens/patient/store/patient_store.dart';
import 'package:solidcare/screens/splash_screen.dart';
import 'package:solidcare/store/AppStore.dart';
import 'package:solidcare/store/AppointmentAppStore.dart';
import 'package:solidcare/store/ListAppStore.dart';
import 'package:solidcare/store/MultiSelectStore.dart';
import 'package:solidcare/store/UserStore.dart';
import 'package:solidcare/utils/app_widgets.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/one_signal_notifications.dart';
import 'package:nb_utils/nb_utils.dart';

import 'utils/app_common.dart';

late PackageInfoData packageInfo;

late StreamSubscription<ConnectivityResult> _connectivitySubscription;

AppStore appStore = AppStore();
PatientStore patientStore = PatientStore();
ListAppStore listAppStore = ListAppStore();
AppointmentAppStore appointmentAppStore = AppointmentAppStore();
MultiSelectStore multiSelectStore = MultiSelectStore();

UserStore userStore = UserStore();
ListAnimationType listAnimationType = ListAnimationType.Slide;

List<Clinic> cachedClinicList = [];
List<BillListData> cachedBillRecordList = [];
List<ReportData> cachedReportList = [];
List<EncounterModel> cachedEncounterList = [];

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

  runApp(MyApp());
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
    initializeOneSignal();
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
