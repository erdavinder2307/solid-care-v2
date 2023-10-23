import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/patient_list_model.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/network/network_utils.dart';
import 'package:solidcare/screens/patient/models/news_model.dart';
import 'package:solidcare/utils/app_common.dart';
import 'package:solidcare/utils/cached_value.dart';
import 'package:solidcare/utils/common.dart';
// ignore: unused_import
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

Future<NewsModel> getNewsListAPI() async {
  if (!appStore.isConnectedToInternet) {
    return NewsModel();
  }
  NewsModel newsModelData = NewsModel.fromJson(await (handleResponse(
      await buildHttpResponse('kivicare/api/v1/news/get-news-list'))));
  cachedNewsFeed = newsModelData;
  return newsModelData;
}

Future<List<UserModel>> getPatientListAPI({
  String? searchString,
  required int page,
  Function(bool)? lastPageCallback,
  Function(int)? getTotalPatient,
  required List<UserModel> patientList,
  int? clinicId,
  int? doctorId,
}) async {
  if (!appStore.isConnectedToInternet) {
    return [];
  }

  List<String> params = [];

  if (searchString.validate().isNotEmpty) params.add('s=$searchString');
  if (clinicId != null) params.add('clinic_id=$clinicId');
  /*if (doctorId != null) params.add('doctor_id=$doctorId');*/

  PatientListModel res = PatientListModel.fromJson(await handleResponse(
      await buildHttpResponse(getEndPoint(
          endPoint: 'kivicare/api/v1/patient/get-list',
          page: page,
          params: params))));

  getTotalPatient?.call(res.total.validate().toInt());

  if (page == 1) patientList.clear();

  lastPageCallback?.call(res.patientData.validate().length != PER_PAGE);

  patientList.addAll(res.patientData.validate());

  appStore.setLoading(false);

  if (isReceptionist()) {
    cachedClinicPatient = patientList;
  } else {
    cachedDoctorPatient = patientList;
  }
  return patientList;
}

//Add patient

Future addNewPatientDataAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(
      'kivicare/api/v1/auth/registration',
      request: request,
      method: HttpMethod.POST));
}

Future updatePatientDataAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(
      'kivicare/api/v1/user/profile-update',
      request: request,
      method: HttpMethod.POST));
}

// End Patient
