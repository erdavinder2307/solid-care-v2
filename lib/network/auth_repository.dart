import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/base_response.dart';
import 'package:solidcare/model/clinic_list_model.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/network/network_utils.dart';
import 'package:solidcare/screens/auth/screens/sign_in_screen.dart';
import 'package:solidcare/utils/cached_value.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'clinic_repository.dart';

Future<UserModel> loginAPI(Map<String, dynamic> req) async {
  UserModel value = UserModel.fromJson(await handleResponse(
      await buildHttpResponse(ApiEndPoints.jwtEndPoint,
          request: req, method: HttpMethod.POST)));
  cachedUserData = value;

  setValue(TOKEN, value.token.validate());

  appStore.setLoggedIn(true);
  if (value.clinic.validate().isNotEmpty) {
    Clinic defaultClinic = value.clinic.validate().first;
    appStore.setCurrency(defaultClinic.extra!.currencyPrefix.validate(),
        initialize: true);
    userStore.setClinicId(defaultClinic.id.validate(), initialize: true);
  }

  setValue(PASSWORD, req['password']);
  setValue(USER_LOGIN, value.userNiceName.validate());
  setValue(USER_DATA, jsonEncode(value));
  setValue(USER_ENCOUNTER_MODULES, jsonEncode(value.encounterModules));
  setValue(USER_PRESCRIPTION_MODULE, jsonEncode(value.prescriptionModule));
  setValue(USER_MODULE_CONFIG, jsonEncode(value.moduleConfig));

  appStore.setLoggedIn(true);
  userStore.setUserEmail(value.userEmail.validate(), initialize: true);
  userStore.setUserProfile(value.profileImage.validate(), initialize: true);
  userStore.setUserId(value.userId.validate(), initialize: true);
  userStore.setFirstName(value.firstName.validate(), initialize: true);
  userStore.setLastName(value.lastName.validate(), initialize: true);
  userStore.setRole(value.role.validate(), initialize: true);
  userStore.setUserDisplayName(value.userDisplayName.validate(),
      initialize: true);
  userStore.setUserMobileNumber(value.mobileNumber.validate(),
      initialize: true);
  userStore.setUserGender(value.gender.validate(), initialize: true);
  userStore.setUserData(value, initialize: true);

  if (isReceptionist() || isPatient()) {
    getSelectedClinicAPI(
            clinicId: userStore.userClinicId.validate(), isForLogin: true)
        .then((value) {
      userStore.setUserClinic(value);
      userStore.setUserClinicImage(value.profileImage.validate(),
          initialize: true);
      userStore.setUserClinicName(value.name.validate(), initialize: true);
      userStore.setUserClinicStatus(value.status.validate(), initialize: true);
      String clinicAddress = '';

      if (value.city.validate().isNotEmpty) {
        clinicAddress = value.city.validate();
      }
      if (value.country.validate().isNotEmpty) {
        clinicAddress += ' ,' + value.country.validate();
      }
      userStore.setUserClinicAddress(clinicAddress, initialize: true);
    });
  }

  return value;
}

Future<BaseResponses> changePasswordAPI(Map<String, dynamic> request) async {
  return BaseResponses.fromJson(await handleResponse(await buildHttpResponse(
      '${ApiEndPoints.userEndpoint}/${EndPointKeys.changePwdEndPointKey}',
      request: request,
      method: HttpMethod.POST)));
}

Future<BaseResponses> deleteAccountPermanently() async {
  return BaseResponses.fromJson(await handleResponse(await buildHttpResponse(
      '${ApiEndPoints.authEndPoint}/${EndPointKeys.deleteEndPointKey}',
      method: HttpMethod.DELETE)));
}

Future<BaseResponses> logOutApi() async {
  Map req = {
    ConstantKeys.playerIdKey: appStore.playerId,
    ConstantKeys.loggedOutKey: 1
  };
  log(req);

  return BaseResponses.fromJson(await handleResponse(await buildHttpResponse(
      '${ApiEndPoints.authEndPoint}/${EndPointKeys.managePlayerIdEndPointKey}',
      request: req,
      method: HttpMethod.POST)));
}

Future<void> logout({bool isTokenExpired = false}) async {
  if (!isTokenExpired) {
    await logOutApi().catchError((e) {
      appStore.setLoading(false);
      throw e;
    });
  }

  await removeKey(TOKEN);
  await removeKey(USER_ID);
  await removeKey(FIRST_NAME);
  await removeKey(LAST_NAME);
  await removeKey(USER_EMAIL);
  await removeKey(USER_DISPLAY_NAME);
  await removeKey(PROFILE_IMAGE);
  await removeKey(USER_MOBILE);
  await removeKey(USER_GENDER);
  await removeKey(USER_ROLE);
  await removeKey(PASSWORD);
  await removeKey(USER_DATA);
  await removeKey(PLAYER_ID);
  appStore.setPlayerId('');
  OneSignal.User.pushSubscription.optOut();
  if (isDoctor()) {
    cachedDoctorAppointment = null;
    cachedDoctorAppointment = [];
    cachedDoctorPatient = [];
  }
  if (isReceptionist()) {
    cachedReceptionistAppointment = null;
    cachedDoctorList = [];
    cachedClinicPatient = [];
  }
  if (isPatient()) {
    cachedPatientAppointment = [];
    cachedPatientAppointment = null;
  }

  OneSignal.logout();
  await removeKey(SharedPreferenceKey.cachedDashboardDataKey);

  removePermission();

  userStore.setClinicId('');
  appStore.setLoggedIn(false);
  appStore.setLoading(false);
  paymentMethodList.clear();
  paymentMethodImages.clear();
  paymentModeList.clear();

  push(SignInScreen(),
      isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
}

void removePermission() {
  removeKey(USER_PERMISSION);
  removeKey(SharedPreferenceKey.solidCareAppointmentAddKey);
  removeKey(SharedPreferenceKey.solidCareAppointmentDeleteKey);
  removeKey(SharedPreferenceKey.solidCareAppointmentEditKey);
  removeKey(SharedPreferenceKey.solidCareAppointmentListKey);
  removeKey(SharedPreferenceKey.solidCareAppointmentViewKey);
  removeKey(SharedPreferenceKey.solidCarePatientAppointmentStatusChangeKey);
  removeKey(SharedPreferenceKey.solidCareAppointmentExportKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillAddKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillEditKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillListKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillExportKey);
  removeKey(SharedPreferenceKey.solidCarePatientBillViewKey);
  removeKey(SharedPreferenceKey.solidCareClinicAddKey);
  removeKey(SharedPreferenceKey.solidCareClinicDeleteKey);
  removeKey(SharedPreferenceKey.solidCareClinicEditKey);
  removeKey(SharedPreferenceKey.solidCareClinicListKey);
  removeKey(SharedPreferenceKey.solidCareClinicProfileKey);
  removeKey(SharedPreferenceKey.solidCareClinicViewKey);
  removeKey(SharedPreferenceKey.solidCareMedicalRecordsAddKey);
  removeKey(SharedPreferenceKey.solidCareMedicalRecordsDeleteKey);
  removeKey(SharedPreferenceKey.solidCareMedicalRecordsEditKey);
  removeKey(SharedPreferenceKey.solidCareMedicalRecordsListKey);
  removeKey(SharedPreferenceKey.solidCareMedicalRecordsViewKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalAppointmentKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalDoctorKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalPatientKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalRevenueKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalTodayAppointmentKey);
  removeKey(SharedPreferenceKey.solidCareDashboardTotalServiceKey);
  removeKey(SharedPreferenceKey.solidCareDoctorAddKey);
  removeKey(SharedPreferenceKey.solidCareDoctorDeleteKey);
  removeKey(SharedPreferenceKey.solidCareDoctorEditKey);
  removeKey(SharedPreferenceKey.solidCareDoctorDashboardKey);
  removeKey(SharedPreferenceKey.solidCareDoctorListKey);
  removeKey(SharedPreferenceKey.solidCareDoctorViewKey);
  removeKey(SharedPreferenceKey.solidCareDoctorExportKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterAddKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterEditKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterExportKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterListKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncountersKey);
  removeKey(SharedPreferenceKey.solidCarePatientEncounterViewKey);
  removeKey(SharedPreferenceKey.solidCareEncountersTemplateAddKey);
  removeKey(SharedPreferenceKey.solidCareEncountersTemplateDeleteKey);
  removeKey(SharedPreferenceKey.solidCareEncountersTemplateEditKey);
  removeKey(SharedPreferenceKey.solidCareEncountersTemplateListKey);
  removeKey(SharedPreferenceKey.solidCareEncountersTemplateViewKey);
  removeKey(SharedPreferenceKey.solidCareClinicScheduleKey);
  removeKey(SharedPreferenceKey.solidCareClinicScheduleAddKey);
  removeKey(SharedPreferenceKey.solidCareClinicScheduleDeleteKey);
  removeKey(SharedPreferenceKey.solidCareClinicScheduleEditKey);
  removeKey(SharedPreferenceKey.solidCareClinicScheduleExportKey);
  removeKey(SharedPreferenceKey.solidCareDoctorSessionAddKey);
  removeKey(SharedPreferenceKey.solidCareDoctorSessionEditKey);
  removeKey(SharedPreferenceKey.solidCareDoctorSessionListKey);
  removeKey(SharedPreferenceKey.solidCareDoctorSessionDeleteKey);
  removeKey(SharedPreferenceKey.solidCareDoctorSessionExportKey);
  removeKey(SharedPreferenceKey.solidCareChangePasswordKey);
  removeKey(SharedPreferenceKey.solidCarePatientReviewAddKey);
  removeKey(SharedPreferenceKey.solidCarePatientReviewDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePatientReviewEditKey);
  removeKey(SharedPreferenceKey.solidCarePatientReviewGetKey);
  removeKey(SharedPreferenceKey.solidCareDashboardKey);
  removeKey(SharedPreferenceKey.solidCarePatientAddKey);
  removeKey(SharedPreferenceKey.solidCarePatientDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePatientClinicKey);
  removeKey(SharedPreferenceKey.solidCarePatientProfileKey);
  removeKey(SharedPreferenceKey.solidCarePatientEditKey);
  removeKey(SharedPreferenceKey.solidCarePatientListKey);
  removeKey(SharedPreferenceKey.solidCarePatientExportKey);
  removeKey(SharedPreferenceKey.solidCarePatientViewKey);
  removeKey(SharedPreferenceKey.solidCareReceptionistProfileKey);
  removeKey(SharedPreferenceKey.solidCarePatientReportKey);
  removeKey(SharedPreferenceKey.solidCarePatientReportAddKey);
  removeKey(SharedPreferenceKey.solidCarePatientReportEditKey);
  removeKey(SharedPreferenceKey.solidCarePatientReportViewKey);
  removeKey(SharedPreferenceKey.solidCarePatientReportDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionAddKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionDeleteKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionEditKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionViewKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionListKey);
  removeKey(SharedPreferenceKey.solidCarePrescriptionExportKey);
  removeKey(SharedPreferenceKey.solidCareServiceAddKey);
  removeKey(SharedPreferenceKey.solidCareServiceDeleteKey);
  removeKey(SharedPreferenceKey.solidCareServiceEditKey);
  removeKey(SharedPreferenceKey.solidCareServiceExportKey);
  removeKey(SharedPreferenceKey.solidCareServiceListKey);
  removeKey(SharedPreferenceKey.solidCareServiceViewKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataAddKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataDeleteKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataEditKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataExportKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataListKey);
  removeKey(SharedPreferenceKey.solidCareStaticDataViewKey);
}

Future<UserModel> getSingleUserDetailAPI(int? id) async {
  return UserModel.fromJson(await (handleResponse(await buildHttpResponse(
      '${ApiEndPoints.userEndpoint}/${EndPointKeys.getDetailEndPointKey}?${ConstantKeys.capitalIDKey}=$id'))));
}

//Post API Change

Future<BaseResponses> forgotPasswordAPI(Map<String, dynamic> request) async {
  return BaseResponses.fromJson(await handleResponse(await buildHttpResponse(
      '${ApiEndPoints.userEndpoint}/${EndPointKeys.forgetPwdEndPointKey}',
      request: request,
      method: HttpMethod.POST)));
}

Future<void> updateProfileAPI(
    {required Map<String, dynamic> data,
    File? profileImage,
    File? doctorSignature}) async {
  var multiPartRequest = await getMultiPartRequest(
      '${ApiEndPoints.userEndpoint}/${EndPointKeys.updateProfileEndPointKey}');

  multiPartRequest.fields.addAll(await getMultipartFields(val: data));

  log("${ConstantKeys.multiPartRequestKey} ${multiPartRequest.fields}");
  multiPartRequest.headers.addAll(buildHeaderTokens());

  if (profileImage != null) {
    multiPartRequest.files
        .add(await MultipartFile.fromPath('profile_image', profileImage.path));
  }

  if (doctorSignature != null) {
    String convertedImage = await convertImageToBase64(doctorSignature);
    multiPartRequest.files
        .add(MultipartFile.fromString('signature_img', convertedImage));
  }
  appStore.setLoading(true);

  await sendMultiPartRequest(multiPartRequest, onSuccess: (temp) async {
    appStore.setLoading(false);

    log("Response: $temp");
    UserModel data = UserModel.fromJson(temp['data']);
    cachedUserData = data;

    userStore.setFirstName(data.firstName.validate(), initialize: true);
    userStore.setLastName(data.lastName.validate(), initialize: true);
    userStore.setUserMobileNumber(data.mobileNumber.validate(),
        initialize: true);
    if (data.profileImage != null) {
      userStore.setUserProfile(data.profileImage.validate(), initialize: true);
    }
    toast(temp['message'], print: true);
    finish(getContext, true);
  }, onError: (error) {
    toast(error.toString(), print: true);
    appStore.setLoading(false);
  });
}

//region CommonFunctions
Future<Map<String, String>> getMultipartFields(
    {required Map<String, dynamic> val}) async {
  Map<String, String> data = {};

  val.forEach((key, value) {
    data[key] = '$value';
  });

  return data;
}

Future<List<MultipartFile>> getMultipartImages(
    {required List<File> files, required String name}) async {
  List<MultipartFile> multiPartRequest = [];

  await Future.forEach<File>(files, (element) async {
    int i = files.indexOf(element);

    multiPartRequest.add(await MultipartFile.fromPath(
        '${'$name' + i.toString()}', element.path));
  });

  return multiPartRequest;
}

//endregion
