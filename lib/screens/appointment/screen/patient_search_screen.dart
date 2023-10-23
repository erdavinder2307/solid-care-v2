import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:solidcare/components/empty_error_state_component.dart';
import 'package:solidcare/components/image_border_component.dart';
import 'package:solidcare/components/loader_widget.dart';
import 'package:solidcare/components/no_data_found_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/network/patient_list_repository.dart';
import 'package:solidcare/screens/shimmer/screen/patient_search_shimmer_screen.dart';
import 'package:solidcare/utils/app_common.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/extensions/string_extensions.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class PatientSearchScreen extends StatefulWidget {
  final UserModel? selectedData;

  PatientSearchScreen({Key? key, this.selectedData}) : super(key: key);

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  Future<List<UserModel>>? future;

  List<UserModel> patientList = [];

  TextEditingController searchCont = TextEditingController();

  int page = 1;

  bool isLastPage = false;
  bool isFirst = true;
  bool showClear = false;

  UserModel? selectedData;

  @override
  void initState() {
    super.initState();
    init(showLoader: false);
  }

  Future<void> init({bool showLoader = true}) async {
    if (showLoader) {
      appStore.setLoading(true);
    }

    future = getPatientListAPI(
      searchString: searchCont.text,
      patientList: patientList,
      clinicId: isReceptionist()
          ? userStore.userClinicId.toInt()
          : appointmentAppStore.mClinicSelected?.id.toInt(),
      page: 1,
      lastPageCallback: (b) => isLastPage = b,
    ).then((value) {
      if (searchCont.text.isNotEmpty) {
        showClear = true;
      } else {
        showClear = false;
      }
      setState(() {});
      appStore.setLoading(false);
      return value;
    }).catchError((e) {
      appStore.setLoading(false);
      setState(() {});
      throw e;
    });
  }

  void _onSearchClear() async {
    hideKeyboard(context);
    searchCont.clear();
    init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('${locale.lblPatientList} ',
          textColor: Colors.white,
          systemUiOverlayStyle: defaultSystemUiOverlayStyle(context)),
      body: Observer(builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            AppTextField(
              controller: searchCont,
              textFieldType: TextFieldType.NAME,
              decoration: inputDecoration(
                context: context,
                hintText: locale.lblSearchPatient,
                prefixIcon: ic_search.iconImage().paddingAll(16),
                suffixIcon: !showClear
                    ? Offstage()
                    : ic_clear.iconImage().paddingAll(16).onTap(
                        () {
                          _onSearchClear();
                        },
                        borderRadius: radius(),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
              ),
              onChanged: (newValue) {
                if (newValue.isEmpty) {
                  showClear = false;
                  _onSearchClear();
                } else {
                  Timer(Duration(milliseconds: 500), () {
                    init(showLoader: true);
                  });
                  showClear = true;
                }
                setState(() {});
              },
              onFieldSubmitted: (searchString) {
                hideKeyboard(context);

                init(showLoader: true);
              },
            ).paddingSymmetric(horizontal: 16, vertical: 16),
            SnapHelperWidget<List<UserModel>>(
              future: future,
              loadingWidget: PatientSearchShimmerScreen(),
              errorBuilder: (error) {
                return NoDataWidget(
                  imageWidget: Image.asset(
                    ic_somethingWentWrong,
                    height: 180,
                    width: 180,
                  ),
                  title: error.toString(),
                );
              },
              errorWidget: ErrorStateWidget(),
              onSuccess: (snap) {
                if (widget.selectedData != null && isFirst) {
                  selectedData = snap.firstWhere((element) =>
                      element.iD.validate() ==
                      widget.selectedData!.iD.validate());
                  isFirst = false;
                }
                snap.retainWhere((element) =>
                    element.userStatus.toInt() == ACTIVE_USER_INT_STATUS);
                if (snap.isEmpty && !appStore.isLoading) {
                  return SingleChildScrollView(
                          child: NoDataFoundWidget(
                              text: searchCont.text.isEmpty
                                  ? locale.lblNoActivePatientAvailable
                                  : locale.lblCantFindPatientYouSearchedFor))
                      .center();
                }
                return AnimatedScrollView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
                  disposeScrollController: true,
                  listAnimationType: ListAnimationType.None,
                  physics: AlwaysScrollableScrollPhysics(),
                  slideConfiguration: SlideConfiguration(verticalOffset: 400),
                  onSwipeRefresh: () async {
                    page = 1;
                    init(showLoader: false);
                    return await 1.seconds.delay;
                  },
                  onNextPage: () async {
                    if (!isLastPage) {
                      setState(() {
                        page++;
                      });
                      init(showLoader: true);
                      await 1.seconds.delay;
                    }
                  },
                  children: [
                    ...snap.map(
                      (e) {
                        UserModel data = e;
                        return Container(
                          decoration: boxDecorationDefault(
                              boxShadow: [], color: context.cardColor),
                          child: RadioListTile<UserModel>(
                            controlAffinity: ListTileControlAffinity.trailing,
                            tileColor: context.cardColor,
                            secondary: data.profileImage.validate().isNotEmpty
                                ? ImageBorder(
                                    src: data.profileImage.validate(),
                                    height: 30,
                                  )
                                : GradientBorder(
                                    gradient: LinearGradient(colors: [
                                      primaryColor,
                                      appSecondaryColor
                                    ], tileMode: TileMode.mirror),
                                    strokeWidth: 2,
                                    borderRadius: 80,
                                    child: PlaceHolderWidget(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      shape: BoxShape.circle,
                                      child: Text(
                                          data.displayName
                                              .validate(value: 'P')[0]
                                              .capitalizeFirstLetter(),
                                          style: boldTextStyle(
                                              color: Colors.black)),
                                    ),
                                  ),
                            shape:
                                RoundedRectangleBorder(borderRadius: radius()),
                            value: data,
                            title: Text(
                                data.displayName
                                    .capitalizeEachWord()
                                    .validate(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: primaryTextStyle()),
                            onChanged: (v) {
                              selectedData = v;
                              setState(() {});
                            },
                            groupValue: selectedData,
                          ),
                        ).paddingSymmetric(vertical: 8);
                      },
                    ).toList(),
                  ],
                );
              },
            ).paddingTop(70),
            LoaderWidget().visible(appStore.isLoading).center()
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          finish(context, selectedData);
        },
      ),
    );
  }
}
