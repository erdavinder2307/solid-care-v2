import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:solidcare/components/empty_error_state_component.dart';
import 'package:solidcare/components/internet_connectivity_widget.dart';
import 'package:solidcare/components/loader_widget.dart';
import 'package:solidcare/screens/patient/components/clinic_component.dart';
import 'package:solidcare/screens/shimmer/screen/switch_clinic_shimmer_screen.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:solidcare/main.dart';
import 'package:solidcare/model/clinic_list_model.dart';
import 'package:solidcare/network/clinic_repository.dart';
import 'package:solidcare/utils/app_common.dart';

class PatientClinicSelectionScreen extends StatefulWidget {
  final VoidCallback? callback;
  PatientClinicSelectionScreen({this.callback});
  @override
  _PatientClinicSelectionScreenState createState() =>
      _PatientClinicSelectionScreenState();
}

class _PatientClinicSelectionScreenState
    extends State<PatientClinicSelectionScreen> {
  Future<List<Clinic>>? future;

  List<Clinic> clinicList = [];

  int page = 1;

  int selectedIndex = -1;

  bool isLastPage = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getClinicListAPI(
      page: page,
      clinicList: clinicList,
      lastPageCallback: (p0) => isLastPage = p0,
    ).then((value) {
      selectedIndex = value.indexWhere(
          (element) => element.id.validate() == userStore.userClinicId);
      return value;
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
      throw e;
    });
  }

  Future<void> switchFavouriteClinic(int selectedClinicId, int newIndex) async {
    int originalIndex = selectedIndex;
    selectedIndex = newIndex;
    setState(() {});

    showConfirmDialogCustom(
      context,
      dialogType: DialogType.CONFIRMATION,
      title: locale.lblDoYouWantToSwitchYourClinicTo,
      onCancel: (p0) {
        selectedIndex = originalIndex;
        setState(() {});
      },
      onAccept: (_) async {
        appStore.setLoading(true);
        Map<String, dynamic> req = {'clinic_id': selectedClinicId};

        try {
          var value = await switchClinicApi(req: req);
          toast(value['message']);
          appStore.setLoading(false);
          if (value['status'] == true) {
            widget.callback?.call();
            userStore.setClinicId(selectedClinicId.toString());
            getSelectedClinicAPI(clinicId: userStore.userClinicId.validate())
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
              userStore.setUserClinicAddress(clinicAddress, initialize: true);
            });
          } else {
            selectedIndex = originalIndex;
          }
          setState(() {});
        } catch (e) {
          selectedIndex = originalIndex;
          setState(() {});
          toast(e.toString());
        } finally {
          appStore.setLoading(false);
        }
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildBodyWidget() {
    return InternetConnectivityWidget(
      retryCallback: () => setState(() {}),
      child: Stack(
        children: [
          SnapHelperWidget<List<Clinic>>(
            future: future,
            errorBuilder: (error) {
              return NoDataWidget(
                imageWidget:
                    Image.asset(ic_somethingWentWrong, height: 180, width: 180),
                title: error.toString(),
              );
            },
            errorWidget: ErrorStateWidget(),
            loadingWidget: SwitchClinicShimmerScreen(),
            onSuccess: (snap) {
              return AnimatedScrollView(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                listAnimationType: ListAnimationType.None,
                children: [
                  AnimatedWrap(
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: snap.length,
                    itemBuilder: (p0, index) {
                      return ClinicComponent(
                        clinicData: snap[index],
                        isCheck: selectedIndex == index,
                        onTap: (isCheck) async {
                          await switchFavouriteClinic(
                              snap[index].id.validate().toInt(), index);
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Observer(
              builder: (context) =>
                  LoaderWidget().visible(appStore.isLoading)).center()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        locale.lblMyClinic,
        textColor: Colors.white,
        systemUiOverlayStyle: defaultSystemUiOverlayStyle(context),
        elevation: 0,
        color: appPrimaryColor,
      ),
      body: buildBodyWidget(),
    );
  }
}
