import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/clinic_list_model.dart';
import 'package:solidcare/network/network_utils.dart';
import 'package:solidcare/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

Future<Clinic> getSelectedClinicAPI(
    {int? page, required String clinicId, bool isForLogin = false}) async {
  ClinicListModel res = ClinicListModel.fromJson(await (handleResponse(
      await buildHttpResponse(
          'kivicare/api/v1/clinic/get-list?page=${page != null ? page : ''}'))));
  if (!isForLogin)
    appointmentAppStore.setSelectedClinic(res.clinicData
        .validate()
        .firstWhere((element) => element.id.validate() == clinicId));
  return res.clinicData
      .validate()
      .firstWhere((element) => element.id.validate() == clinicId);
}

Future<List<Clinic>> getClinicListAPI({
  String? searchString,
  required int page,
  Function(bool)? lastPageCallback,
  required List<Clinic> clinicList,
}) async {
  if (!appStore.isConnectedToInternet) {
    return [];
  }

  List<String> params = [];
  if (searchString.validate().isNotEmpty) params.add('s=$searchString');

  ClinicListModel res = ClinicListModel.fromJson(await (handleResponse(
      await buildHttpResponse(getEndPoint(
          endPoint: 'kivicare/api/v1/clinic/get-list',
          page: page,
          params: params)))));

  cachedClinicList = res.clinicData.validate();

  if (page == 1) clinicList.clear();

  lastPageCallback?.call(res.clinicData.validate().length != PER_PAGE);

  clinicList.addAll(res.clinicData.validate());

  return clinicList;
}

Future switchClinicApi({required Map req}) async {
  return (await handleResponse(await buildHttpResponse(
      'kivicare/api/v1/patient/switch-clinic',
      request: req,
      method: HttpMethod.POST)));
}
