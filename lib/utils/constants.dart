import 'package:solidcare/main.dart';
import 'package:flutter/material.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/upcoming_appointment_model.dart';

const DEMO_URL = '';
const RAZOR_URL = 'https://api.razorpay.com/v1';

const DEFAULT_SERVICE_IMAGE_URL =
    'https://img.freepik.com/free-photo/orange-background_23-2147674307.jpg?w=900&t=st=1682404076~exp=1682404676~hmac=d2eaa5ed2910063112dbfa9cdfb15e1d967ac221b518ca7d1dd47f805ea3a7dd';

// ignore: non_constant_identifier_names
List<String> RTLLanguage = ['ar'];

List<WeeklyAppointment> emptyGraphList = [
  WeeklyAppointment(x: locale.lblMonday, y: 0),
  WeeklyAppointment(x: locale.lblTuesday, y: 0),
  WeeklyAppointment(x: locale.lblWednesday, y: 0),
  WeeklyAppointment(x: locale.lblThursday, y: 0),
  WeeklyAppointment(x: locale.lblFriday, y: 0),
  WeeklyAppointment(x: locale.lblSaturday, y: 0),
  WeeklyAppointment(x: locale.lblSunday, y: 0),
];

List<String> userRoles = [locale.lblDoctor, locale.lblClinic]; // Loader Size
double loaderSize = 30;

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(
        id: 0,
        name: locale.lblEnglish,
        languageCode: 'en',
        fullLanguageCode: 'en-US',
        flag: flagsIcUs),
    LanguageDataModel(
        id: 1,
        name: locale.lblArabic,
        languageCode: 'ar',
        fullLanguageCode: 'ar-AR',
        flag: flagsIcAr),
    LanguageDataModel(
        id: 2,
        name: locale.lblHindi,
        languageCode: 'hi',
        fullLanguageCode: 'hi-IN',
        flag: flagsIcIndia),
    LanguageDataModel(
        id: 3,
        name: locale.lblGerman,
        languageCode: 'de',
        fullLanguageCode: 'de-DE',
        flag: flagsIcGermany),
    LanguageDataModel(
        id: 4,
        name: locale.lblFrench,
        languageCode: 'fr',
        fullLanguageCode: 'fr-FR',
        flag: flagsIcFrench),
  ];
}

// local
const receptionistEmail = "calvin@solidcare.org";
const doctorEmail = "doctor@solidcare.org";
const patientEmail = "mike@solidcare.org";

//Demo Password
const loginPassword = "123456";

/* Theme Mode Type */
const THEME_MODE_LIGHT = 0;
const THEME_MODE_DARK = 1;
const THEME_MODE_SYSTEM = 2;

/* DateFormats */
const FORMAT_12_HOUR = 'hh:mm a';
const ONLY_HOUR_MINUTE = 'HH:mm';
const TIME_WITH_SECONDS = 'hh:mm:ss';
const DISPLAY_DATE_FORMAT = 'dd-MMM-yyyy';
const SAVE_DATE_FORMAT = 'yyyy-MM-dd';

const CONFIRM_APPOINTMENT_FORMAT = "EEEE, MMM dd yyyy";
const GLOBAL_FORMAT = 'dd-MM-yyyy';

const tokenStream = 'tokenStream';

const TOTAL_PATIENT = "Total Patient";
const TOTAL_DOCTOR = "Total Doctors";
const TOTAL_SERVICE = 'Total Service';

// Static DATA
const SPECIALIZATION = "specialization";
const SERVICE_TYPE = "service_type";

// Holidays
const DOCTOR = "doctor";
const CLINIC = "clinic";

const CLINIC_ID = 'CLINIC_ID';

// User Roles
const UserRoleDoctor = 'doctor';
const UserRolePatient = 'patient';
const UserRoleReceptionist = 'receptionist';

// Shared preferences keys
const USER_NAME = 'USER_NAME';

const USER_PASSWORD = 'USER_PASSWORD';
const IS_LOGGED_IN = 'IS_LOGGED_IN';
const IS_REMEMBER_ME = 'IS_REMEMBER_ME';
const TOKEN = 'TOKEN';
const LANGUAGE = 'LANGUAGE';
const SELECTED_LANGUAGE = "SELECTED_LANGUAGE";
const USER_ID = "USER_ID";
const USER_DATA = "USER_DATA";
const FIRST_NAME = "FIRST_NAME";
const LAST_NAME = "LAST_NAME";
const USER_EMAIL = "USER_EMAIL";
const USER_DOB = 'USER_DOB';
const USER_LOGIN = "USER_LOGIN";
const USER_MOBILE = 'USER_MOBILE';
const USER_GENDER = 'USER_GENDER';
const SELECTED_PROFILE_INDEX = 'SELECTED_PROFILE_INDEX';

const USER_CLINIC_NAME = 'USER_CLINIC_NAME';
const USER_CLINIC_IMAGE = 'USER_CLINIC_IMAGE';
const USER_CLINIC_ADDRESS = 'USER_CLINIC_ADDRESS';
const USER_CLINIC_STATUS = 'USER_CLINIC_STATUS';

const USER_DISPLAY_NAME = "USER_DISPLAY_NAME";
const PROFILE_IMAGE = "PROFILE_IMAGE";
const DEMO_DOCTOR = "DEMO_DOCTOR";
const DEMO_RECEPTIONIST = "DEMO_RECEPTIONIST";
const DEMO_PATIENT = "DEMO_PATIENT";
const PASSWORD = "PASSWORD";
const USER_ROLE = "USER_ROLE";
const USER_CLINIC = "USER_CLINIC";
const CACHED_DASHBOARD_MODEL = 'CACHED_DASHBOARD_MODEL';
const CACHED_USER_DATA = 'CACHED_USER_DATA';
const USER_PERMISSION = "USER_PERMISSION";

const USER_PRO_ENABLED = "USER_PRO_ENABLED";
const USER_ENCOUNTER_MODULES = "USER_ENCOUNTER_MODULES";
const USER_PRESCRIPTION_MODULE = "USER_PRESCRIPTION_MODULE";
const USER_MODULE_CONFIG = "USER_MODULE_CONFIG";

const GLOBAL_DATE_FORMAT = "GLOBAL_DATE_FORMAT";
const DATE_FORMAT = 'DATE_FORMAT';
const USER_MEET_SERVICE = "USER_MEET_SERVICE";
const USER_ZOOM_SERVICE = "USER_ZOOM_SERVICE";
const RESTRICT_APPOINTMENT_POST = "RESTRICT_APPOINTMENT_POST";
const RESTRICT_APPOINTMENT_PRE = "RESTRICT_APPOINTMENT_PRE";
const GLOBAL_UTC = 'GLOBAL_UTC';
const CURRENCY = "CURRENCY";
const CURRENCY_POST_FIX = "CURRENCY_POST_FIX";
const CURRENCY_PRE_FIX = 'CURRENCY_PRE_FIX';
const IS_WALKTHROUGH_FIRST = "IS_WALKTHROUGH_FIRST";
const ON = "on";
const OFF = "off";
const SAVE_BASE_URL = "SAVE_BASE_URL";

const PROBLEM = "problem";
const OBSERVATION = "observation";
const NOTE = "note";
const PRESCRIPTION = 'prescription';
const REPORT = 'report';

const UPDATE = "UPDATE";
const DELETE = "DELETE";
const APP_UPDATE = "APP_UPDATE";
const CHANGE_DATE = "CHANGE_DATE";
const DEMO_EMAILS = 'demoEmails';

int titleTextSize = 18;
int fragmentTextSize = 22;

const packageName = "org.solidevelectrosoft.solidcare";

Future<bool> get isIqonicProduct async => await getPackageName() == packageName;
ThemeMode get appThemeMode =>
    appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light;

///LiveStream keys
const UPDATE_APPOINTMENTS = 'UPDATE_APPOINTMENTS';
const UPDATE_ENCOUNTERS = 'UPDATE_ENCOUNTERS';
const UPDATE_BILLS = 'UPDATE_BILLS';
const UPDATE_SESSIONS = 'UPDATE_SESSIONS';

const CACHED_FEEDS_ARTICLES = 'CACHED_FEEDS_ARTICLES';

const DOCTOR_ADD_API_UNSUCCESS_MESSAGE =
    "Sorry, that email address is already used!";

const PLAYER_ID = "PLAYER_ID";

const ONESIGNAL_API_KEY = 'ONESIGNAL_API_KEY';

const CURRENCY_SYMBOL = 'CURRENCY_SYMBOL';
const CURRENCY_CODE = 'CURRENCY_CODE';

const RAZOR_PAY_KEY = 'RAZOR_PAY_KEY';
const RAZOR_PAY_SECRET_KEY = 'RAZOR_PAY_SECRET_KEY';

const PAYMENT_WOOCOMMERCE = 'paymentWoocommerce';
const PAYMENT_RAZORPAY = 'paymentRazorpay';
const PAYMENT_STRIPE = 'paymentStripepay';
const PAYMENT_OFFLINE = 'paymentOffline';

//APP SETTINGS KEYS
const APP_NOTIFICATIONS = 'APP_NOTIFICATIONS';
const APP_THEME = 'APP_THEME';
const App_LANGUAGE_CODE = 'APP_LANGUAGE_CODE';

//STATUS
const BookedStatus = 'Booked';
const CheckOutStatus = 'Check out';
const CheckInStatus = 'Check in';
const CancelledStatus = 'Cancelled';
const PendingStatus = 'Pending';

const BookedStatusInt = 1;
const CheckOutStatusInt = 3;
const CheckInStatusInt = 4;
const CancelledStatusInt = 0;
const PendingStatusInt = 2;

const ClosedEncounterStatus = 'Closed';
const ActiveEncounterStatus = 'Active';
const InActiveEncounterStatus = 'Inactive';

const ClosedEncounterStatusInt = 0;
const ActiveEncounterStatusInt = 1;
const InActiveEncounterStatusInt = 2;

const ACTIVE_USER_INT_STATUS = 1;
const INACTIVE_USER_INT_STATUS = 0;

const ACTIVE_SERVICE_STATUS = "1";
const INACTIVE_SERVICE_STATUS = "0";

const ACTIVE_CLINIC_STATUS = "1";
const INACTIVE_CLINIC_STATUS = "0";

const regularExpressionForCheckSpecialChar = "";

class ApiEndPoints {
  static final jwtEndPoint = 'jwt-auth/v1/token';

  static final getConfigurationEndPoint =
      'kivicare/api/v1/user/get-configuration';
  static String appointmentEndPoint = 'kivicare/api/v1/appointment';

  static final saveLanguageApiEndPoint = '';
  static String saveAppointmentEndPoint = 'kivicare/api/v2/appointment/save';

  static String updateAppointmentStatusEndPoint =
      'kivicare/api/v1/appointment/update-status';

  static String deleteAppointmentEndPoint =
      'kivicare/api/v1/appointment/delete';

  static String getAppointmentEndPoint =
      'kivicare/api/v1/appointment/get-appointment';
  static String getAppointmentTimeSlotsEndpoint =
      'kivicare/api/v1/doctor/appointment-time-slot';
  static String authEndPoint = 'kivicare/api/v1/auth';
  static String userEndpoint = 'kivicare/api/v1/user';
  static String patientEndPoint = 'kivicare/api/v1/patient';
  static String doctorEndPoint = 'kivicare/api/v1/doctor';
  static String receptionistEndPoint = '';

  static String savePaymentEndPoint =
      'kivicare/api/v1/appointment/payment-status';
  static String razorPaymentEndPoint = 'payments';
  static String razorOrderEndPoint = 'orders';
  static String serviceApiEndPoint = 'kivicare/api/v1/service';
  static String clinicApiEndPoint = 'kivicare/api/v1/clinic';
  static String settingEndPoint = 'kivicare/api/v1/setting';
  static String encounterEndPoint = 'kivicare/api/v1/encounter';
  static String newsEndPoint = 'kivicare/api/v1/news';
  static String prescriptionEndPoint = 'kivicare/api/v1/prescription';
  static String reviewEndPoint = 'kivicare/api/v1/review';

  static String billEndPoint = 'kivicare/api/v1/bill';

  static String billDeleteEndPoint = 'kivicare/api/v1/patient/delete-bill';

  static String taxEndPoint = 'kivicare/api/v1/tax/get';
  static String staticDataEndPoint = 'kivicare/api/v1/staticdata';
}

class EndPointKeys {
  static String getDetailEndPointKey = 'get-detail';

  static final deleteDoctorEndPointKey = 'delete-doctor';

  static final getDoctorClinicSessionEndPointKey = 'get-doctor-clinic-session';

  static String getEncounterDetailEndPointKey = 'get-encounter-detail';

  static String getDashboardKey = 'get-dashboard';

  static String switchClinicEndPointKey = 'switch-clinic';

  static String getListEndPointKey = 'get-list';

  static String forgetPwdEndPointKey = 'forgot-password';

  static String billDetailEndPointKey = 'bill-details';

  static String addBillEndPointKey = 'add-bill';

  static String listEndPointKey = 'list';

  static String updateProfileEndPointKey = 'profile-update';
  static final getAppointmentEndPointKey = 'get-appointment';

  static final changePwdEndPointKey = 'change-password';

  static final deleteEndPointKey = 'delete';

  static final getAppointmentCountEndPointKey = 'get-appointment-count';

  static final managePlayerIdEndPointKey = 'manage-user-player-ids';
}

class ModelKeys {}

class ConstantKeys {
  static final pageKey = 'page';
  static final limitKey = 'limit';

  static final typeKey = 'type';

  static final dateKey = 'date';

  static final startKey = 'start';

  static final endKey = 'end';

  static final playerIdKey = 'player_id';

  static final loggedOutKey = 'logged_out';

  static final doctorsKey = 'doctors';
  static final chargesKey = 'charges';
  static final clinicIdKey = 'clinic_id';
  static final doctorIdKey = 'doctor_id';

  static final visitTypeKey = 'visit_type';

  static final billIdKey = 'bill_id';

  static final patientIdKey = 'patient_id';

  static final encounterIdKey = 'encounter_id';
  static final statusKey = 'status';
  static final durationKey = 'duration';
  static final isTelemedKey = 'is_telemed';
  static final isMultipleKey = 'is_multiple_selection';

  static final mappingTableIdKey = 'mapping_table_id';
  static final serviceMappingIdKey = 'service_mapping_id';

  static final statusKeyAll = 'All';

  static final appointmentReportKey = 'appointment_report_';

  static final capitalIDKey = 'ID';

  static final lowerIdKey = 'id';

  static final attachmentCountsKey = 'attachment_count';

  static final multiPartRequestKey = 'Multipart Request';

  static final localeKey = 'locale';

  static final languageCodeKey = 'language_code';

  static final paymentFailedKey = 'failed';
  static final paymentCapturedKey = 'captured';

  static final appTypeKey = 'appType';
  static final patientAppKey = 'patientApp';
  static final doctorAppKey = 'doctorApp';
  static final receptionistAppKey = 'receptionistApp';

  // Payment Keys constant

  static final paymentWooCommerceKey = 'paymentWoocommerce';
  static final paymentRazorPayKey = 'paymentRazorpay';
  static final paymentStripeKey = 'paymentStripe';
  static final paymentOfflinePayKey = ' paymentOffline';
}

class SharedPreferenceKey {
  //Region Cache Keys

  static final cachedDashboardDataKey = 'CachedDashboardData';

  //End Region

  //Region Payment Keys
  static final paymentMethodsKey = 'Payment Methods';
  static final paymentWooCommerceKey = 'paymentWoocommerce';
  static final paymentRazorPayKey = 'paymentRazorpay';
  static final paymentStripeKey = 'paymentStripe';
  static final paymentOfflinePayKey = ' paymentOffline';
  //Region Appointment Module
  static const solidCareAppointmentAddKey = 'solidCareAppointmentAdd';
  static const solidCareAppointmentDeleteKey = 'solidCareAppointmentDelete';
  static const solidCareAppointmentEditKey = 'solidCareAppointmentEdit';
  static const solidCareAppointmentListKey = 'solidCareAppointmentList';
  static const solidCareAppointmentViewKey = 'solidCareAppointmentView';
  static const solidCarePatientAppointmentStatusChangeKey =
      'solidCarePatientAppointmentStatusChange';
  static const solidCareAppointmentExportKey = 'solidCareAppointmentExport';

  //End Region

  //Region Billing Module
  static const solidCarePatientBillAddKey = 'solidCarePatientBillAdd';
  static const solidCarePatientBillDeleteKey = 'solidCarePatientBillDelete';
  static const solidCarePatientBillEditKey = 'solidCarePatientBillEdit';
  static const solidCarePatientBillListKey = 'solidCarePatientBillList';
  static const solidCarePatientBillExportKey = 'solidCarePatientBillExport';
  static const solidCarePatientBillViewKey = 'solidCarePatientBillView';

  //End Region

  //Region ClinicModule
  static const solidCareClinicAddKey = 'solidCareClinicAdd';
  static const solidCareClinicDeleteKey = 'solidCareClinicDelete';
  static const solidCareClinicEditKey = 'solidCareClinicEdit';
  static const solidCareClinicListKey = 'solidCareClinicList';
  static const solidCareClinicProfileKey = 'solidCareClinicProfile';
  static const solidCareClinicViewKey = 'solidCareClinicView';

  // End Region

  //Region ClinicalDetailModule
  static const solidCareMedicalRecordsAddKey = 'solidCareMedicalRecordsAdd';
  static const solidCareMedicalRecordsDeleteKey =
      'solidCareMedicalRecordsDelete';
  static const solidCareMedicalRecordsEditKey = 'solidCareMedicalRecordsEdit';
  static const solidCareMedicalRecordsListKey = 'solidCareMedicalRecordsList';
  static const solidCareMedicalRecordsViewKey = 'solidCareMedicalRecordsView';

  //End Region

  //Region  DashboardModule
  static const solidCareDashboardTotalAppointmentKey =
      'solidCareDashboardTotalAppointment';
  static const solidCareDashboardTotalDoctorKey =
      'solidCareDashboardTotalDoctor';
  static const solidCareDashboardTotalPatientKey =
      'solidCareDashboardTotalPatient';
  static const solidCareDashboardTotalRevenueKey =
      'solidCareDashboardTotalRevenue';
  static const solidCareDashboardTotalTodayAppointmentKey =
      'solidCareDashboardTotalTodayAppointment';
  static const solidCareDashboardTotalServiceKey =
      'solidCareDashboardTotalService';

  //EndRegion

  //Region DoctorModule
  static const solidCareDoctorAddKey = 'solidCareDoctorAdd';
  static const solidCareDoctorDeleteKey = 'solidCareDoctorDelete';
  static const solidCareDoctorEditKey = 'solidCareDoctorEdit';
  static const solidCareDoctorDashboardKey = 'solidCareDoctorDashboard';
  static const solidCareDoctorListKey = 'solidCareDoctorList';
  static const solidCareDoctorViewKey = 'solidCareDoctorView';
  static const solidCareDoctorExportKey = 'solidCareDoctorExport';

  /// End Region

  /// Region EncounterPermissionModule
  static const solidCarePatientEncounterAddKey = 'solidCarePatientEncounterAdd';
  static const solidCarePatientEncounterDeleteKey =
      'solidCarePatientEncounterDelete';
  static const solidCarePatientEncounterEditKey =
      'solidCarePatientEncounterEdit';
  static const solidCarePatientEncounterExportKey =
      'solidCarePatientEncounterExport';
  static const solidCarePatientEncounterListKey =
      'solidCarePatientEncounterList';
  static const solidCarePatientEncountersKey = 'solidCarePatientEncounters';
  static const solidCarePatientEncounterViewKey =
      'solidCarePatientEncounterView';

  /// End Region

  /// Region EncountersTemplateModule
  static const solidCareEncountersTemplateAddKey =
      'solidCareEncountersTemplateAdd';
  static const solidCareEncountersTemplateDeleteKey =
      'solidCareEncountersTemplateDelete';
  static const solidCareEncountersTemplateEditKey =
      'solidCareEncountersTemplateEdit';
  static const solidCareEncountersTemplateListKey =
      'solidCareEncountersTemplateList';
  static const solidCareEncountersTemplateViewKey =
      'solidCareEncountersTemplateView';

  /// End Region

  /// Region HolidayModule
  static const solidCareClinicScheduleKey = 'solidCareClinicSchedule';
  static const solidCareClinicScheduleAddKey = 'solidCareClinicScheduleAdd';
  static const solidCareClinicScheduleDeleteKey =
      'solidCareClinicScheduleDelete';
  static const solidCareClinicScheduleEditKey = 'solidCareClinicScheduleEdit';
  static const solidCareClinicScheduleExportKey =
      'solidCareClinicScheduleExport';

  /// End Region

  /// Region SessionModule
  static const solidCareDoctorSessionAddKey = 'solidCareDoctorSessionAdd';
  static const solidCareDoctorSessionEditKey = 'solidCareDoctorSessionEdit';
  static const solidCareDoctorSessionListKey = 'solidCareDoctorSessionList';
  static const solidCareDoctorSessionDeleteKey = 'solidCareDoctorSessionDelete';
  static const solidCareDoctorSessionExportKey = 'solidCareDoctorSessionExport';

  /// End Region

  /// Region OtherModule
  static const solidCareChangePasswordKey = 'solidCareChangePassword';
  static const solidCarePatientReviewAddKey = 'solidCarePatientReviewAdd';
  static const solidCarePatientReviewDeleteKey = 'solidCarePatientReviewDelete';
  static const solidCarePatientReviewEditKey = 'solidCarePatientReviewEdit';
  static const solidCarePatientReviewGetKey = 'solidCarePatientReviewGet';
  static const solidCareDashboardKey = 'solidCareDashboard';

  /// End Region

  /// Region PatientModule
  static const solidCarePatientAddKey = 'solidCarePatientAdd';
  static const solidCarePatientDeleteKey = 'solidCarePatientDelete';
  static const solidCarePatientClinicKey = 'solidCarePatientClinic';
  static const solidCarePatientProfileKey = 'solidCarePatientProfile';
  static const solidCarePatientEditKey = 'solidCarePatientEdit';
  static const solidCarePatientListKey = 'solidCarePatientList';
  static const solidCarePatientExportKey = 'solidCarePatientExport';
  static const solidCarePatientViewKey = 'solidCarePatientView';

  /// End Region

  /// Region ReceptionistModule
  static const solidCareReceptionistProfileKey = 'solidCareReceptionistProfile';

  /// End Region

  /// Region ReportModule
  static const solidCarePatientReportKey = 'solidCarePatientReport';
  static const solidCarePatientReportAddKey = 'solidCarePatientReportAdd';
  static const solidCarePatientReportEditKey = 'solidCarePatientReportEdit';
  static const solidCarePatientReportViewKey = 'solidCarePatientReportView';
  static const solidCarePatientReportDeleteKey = 'solidCarePatientReportDelete';

  /// End Region

  /// Region PrescriptionPermissionModule
  static const solidCarePrescriptionAddKey = 'solidCarePrescriptionAdd';
  static const solidCarePrescriptionDeleteKey = 'solidCarePrescriptionDelete';
  static const solidCarePrescriptionEditKey = 'solidCarePrescriptionEdit';
  static const solidCarePrescriptionViewKey = 'solidCarePrescriptionView';
  static const solidCarePrescriptionListKey = 'solidCarePrescriptionList';
  static const solidCarePrescriptionExportKey = 'solidCarePrescriptionExport';

  /// End Region

  /// Region ServiceModule
  static const solidCareServiceAddKey = 'solidCareServiceAdd';
  static const solidCareServiceDeleteKey = 'solidCareServiceDelete';
  static const solidCareServiceEditKey = 'solidCareServiceEdit';
  static const solidCareServiceExportKey = 'solidCareServiceExport';
  static const solidCareServiceListKey = 'solidCareServiceList';
  static const solidCareServiceViewKey = 'solidCareServiceView';

  /// End Region

  /// Region StaticDataModule
  static const solidCareStaticDataAddKey = 'solidCareStaticDataAdd';
  static const solidCareStaticDataDeleteKey = 'solidCareStaticDataDelete';
  static const solidCareStaticDataEditKey = 'solidCareStaticDataEdit';
  static const solidCareStaticDataExportKey = 'solidCareStaticDataExport';
  static const solidCareStaticDataListKey = 'solidCareStaticDataList';
  static const solidCareStaticDataViewKey = 'solidCareStaticDataView';

  /// End Region
}
