import 'package:solidcare/main.dart';
import 'package:solidcare/model/doctor_session_model.dart';
import 'package:solidcare/network/network_utils.dart';

//region Doctor Sessions

Future<DoctorSessionModel> getDoctorSessionDataAPI(
    {String? clinicId = ''}) async {
  if (!appStore.isConnectedToInternet) return DoctorSessionModel();
  return DoctorSessionModel.fromJson(await (handleResponse(await buildHttpResponse(
      'kivicare/api/v1/setting/get-doctor-clinic-session?clinic_id=${clinicId != null ? clinicId : ''}'))));
}

Future addDoctorSessionDataAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(
      'kivicare/api/v1/setting/save-doctor-clinic-session',
      request: request,
      method: HttpMethod.POST));
}

Future deleteDoctorSessionDataAPI(Map request) async {
  return await handleResponse(await buildHttpResponse(
      'kivicare/api/v1/setting/delete-doctor-clinic-session',
      request: request,
      method: HttpMethod.POST));
}

//endregion
