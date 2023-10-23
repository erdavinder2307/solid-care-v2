import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:solidcare/components/multi_select.dart';
import 'package:solidcare/components/price_widget.dart';
import 'package:solidcare/components/role_widget.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/model/service_model.dart';
import 'package:solidcare/model/upcoming_appointment_model.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/screens/appointment/appointment_functions.dart';
import 'package:solidcare/screens/appointment/components/appointment_date_component.dart';
import 'package:solidcare/screens/appointment/components/appointment_slots.dart';
import 'package:solidcare/screens/appointment/components/confirm_appointment_screen.dart';
import 'package:solidcare/screens/appointment/components/file_upload_component.dart';
import 'package:solidcare/screens/appointment/screen/patient_search_screen.dart';
import 'package:solidcare/screens/doctor/screens/service/add_service_screen.dart';
import 'package:solidcare/screens/patient/components/selected_clinic_widget.dart';
import 'package:solidcare/screens/patient/components/selected_doctor_widget.dart';
import 'package:solidcare/screens/receptionist/screens/patient/add_patient_screen.dart';
import 'package:solidcare/utils/app_common.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:solidcare/utils/extensions/string_extensions.dart';
import 'package:solidcare/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class Step3FinalSelectionScreen extends StatefulWidget {
  final int? clinicId;
  final int? doctorId;
  final UpcomingAppointmentModel? data;

  Step3FinalSelectionScreen({
    this.data,
    this.doctorId,
    required this.clinicId,
  });

  @override
  State<Step3FinalSelectionScreen> createState() =>
      _Step3FinalSelectionScreenState();
}

class _Step3FinalSelectionScreenState extends State<Step3FinalSelectionScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController descriptionCont = TextEditingController(text: '');
  TextEditingController patientNameCont = TextEditingController();
  TextEditingController servicesCont = TextEditingController();

  bool isUpdate = false;
  bool isFirstTime = true;

  FocusNode patientNameFocus = FocusNode();
  FocusNode serviceFocus = FocusNode();
  FocusNode dateFocus = FocusNode();
  FocusNode slotFocus = FocusNode();
  FocusNode descFocus = FocusNode();

  UserModel? user;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    multiSelectStore.clearList();

    isUpdate = widget.data != null;

    if (isUpdate) {
      appointmentAppStore
          .setSelectedPatient(widget.data!.patientName.validate());
      appointmentAppStore
          .setSelectedPatientId(widget.data!.patientId.validate().toInt());
      appointmentAppStore.setSelectedTime(widget.data!.getAppointmentTime);

      if (widget.data!.patientName.validate().isNotEmpty) {
        patientNameCont.text = widget.data!.patientName.validate();
      }

      if (widget.data!.appointmentStartDate.validate().isNotEmpty) {}
      if (widget.data!.visitType.validate().isNotEmpty) {
        widget.data!.visitType.validate().forEach((element) {
          multiSelectStore.selectedService.add(ServiceData(
              id: element.id,
              name: element.serviceName,
              serviceId: element.serviceId,
              charges: element.charges));
        });

        servicesCont.text = "${multiSelectStore.selectedService.length} " +
            locale.lblServicesSelected;
      }

      descriptionCont.text = widget.data!.description.validate();

      if (widget.data!.appointmentReport.validate().isNotEmpty) {
        appointmentAppStore.addReportListString(
            data: widget.data!.appointmentReport.validate());
        appointmentAppStore.addReportData(
            data: widget.data!.appointmentReport
                .validate()
                .map((e) => PlatformFile(name: e.url, size: 220))
                .toList());
      }
    }
    setState(() {});
  }

  void selectServices() async {
    await MultiSelectWidget(
      clinicId: isPatient() || isDoctor()
          ? appointmentAppStore.mClinicSelected?.id.toInt()
          : userStore.userClinicId.toInt(),
      selectedServicesId: multiSelectStore.selectedService
          .map((element) => element.serviceId.validate())
          .toList(),
    ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    if (multiSelectStore.selectedService.length > 0)
      servicesCont.text =
          '${multiSelectStore.selectedService.length} ${locale.lblServicesSelected}';
    else {
      servicesCont.text = locale.lblSelectServices;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(locale.lblConfirmAppointment,
          systemUiOverlayStyle: defaultSystemUiOverlayStyle(context),
          textColor: Colors.white),
      body: Form(
        key: formKey,
        autovalidateMode: isFirstTime
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        child: AnimatedScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
          listAnimationType: ListAnimationType.None,
          onSwipeRefresh: () {
            setState(() {});
            return 1.seconds.delay;
          },
          children: [
            stepCountWidget(
              name: locale.lblSelectDateTime,
              currentCount: (isDoctor() || isReceptionist()) ? 2 : 3,
              totalCount: (isDoctor() || isReceptionist()) ? 2 : 3,
              percentage: 1,
            ),
            16.height,
            Row(
              children: [
                if (isProEnabled())
                  SelectedClinicComponent(clinicId: widget.clinicId.validate())
                      .expand(),
                if (isProEnabled()) 16.width,
                SelectedDoctorWidget(
                  clinicId: widget.clinicId.validate(),
                  doctorId: isUpdate
                      ? widget.data!.doctorId.toInt()
                      : widget.doctorId.validate(),
                ).expand(),
              ],
            ),
            16.height,
            RoleWidget(
              isShowDoctor: true,
              isShowReceptionist: true,
              child: Column(
                children: [
                  AppTextField(
                    controller: patientNameCont,
                    textFieldType: TextFieldType.OTHER,
                    focus: patientNameFocus,
                    textInputAction: TextInputAction.next,
                    nextFocus: serviceFocus,
                    validator: (patient) {
                      if (patient!.trim().isEmpty)
                        return locale.lblPatientNameIsRequired;
                      return null;
                    },
                    decoration: inputDecoration(
                      context: context,
                      labelText: locale.lblPatientName,
                      suffixIcon: ic_user
                          .iconImage(size: 10, color: context.iconColor)
                          .paddingAll(14),
                    ),
                    readOnly: true,
                    onTap: () async {
                      PatientSearchScreen(selectedData: user)
                          .launch(context)
                          .then((value) {
                        if (value != null) {
                          user = value as UserModel;
                          appointmentAppStore
                              .setSelectedPatientId(user!.iD.validate());
                          appointmentAppStore
                              .setSelectedPatient(user!.displayName);
                          patientNameCont.text = user!.displayName.validate();
                        }
                      });
                    },
                  ),
                  if (patientNameCont.text.isEmptyOrNull)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(locale.lblAddNewPatient,
                              style: secondaryTextStyle(
                                  color: appPrimaryColor, size: 10))
                          .paddingOnly(top: 10)
                          .onTap(
                            () => AddPatientScreen().launch(context).then(
                              (value) {
                                if (value ?? false) {
                                  init();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                    )
                ],
              ),
            ),
            RoleWidget(
              isShowDoctor: true,
              isShowReceptionist: true,
              child: 16.height,
            ),
            Observer(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: servicesCont,
                      focus: serviceFocus,
                      nextFocus: dateFocus,
                      textInputAction: TextInputAction.next,
                      textFieldType: TextFieldType.NAME,
                      validator: (value) {
                        if (multiSelectStore.selectedService.isEmpty) {
                          return locale.lblSelectServices;
                        } else
                          return null;
                      },
                      decoration: inputDecoration(
                        context: context,
                        labelText: locale.lblSelectServices,
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color: context.iconColor),
                      ).copyWith(
                        border: multiSelectStore.selectedService.isNotEmpty
                            ? OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: radiusOnly(
                                    topLeft: defaultRadius,
                                    topRight: defaultRadius))
                            : null,
                        enabledBorder:
                            multiSelectStore.selectedService.isNotEmpty
                                ? OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: radiusOnly(
                                        topLeft: defaultRadius,
                                        topRight: defaultRadius))
                                : null,
                        focusedBorder:
                            multiSelectStore.selectedService.isNotEmpty
                                ? OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: radiusOnly(
                                        topLeft: defaultRadius,
                                        topRight: defaultRadius))
                                : null,
                      ),
                      readOnly: true,
                      onTap: () {
                        if (!isUpdate) {
                          selectServices();
                        } else {
                          toast(locale.lblEditHolidayRestriction);
                        }
                      },
                    ),
                    if (multiSelectStore.selectedService.isNotEmpty)
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: boxDecorationDefault(
                            color: context.cardColor,
                            borderRadius: radiusOnly(
                                bottomLeft: defaultRadius,
                                bottomRight: defaultRadius)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                        locale.lblService.getApostropheString(
                                            count: multiSelectStore
                                                .selectedService.length,
                                            apostrophe: false),
                                        style: boldTextStyle(size: 12))
                                    .expand(),
                                Text(
                                    locale.lblCharges.getApostropheString(
                                        count: multiSelectStore
                                            .selectedService.length,
                                        apostrophe: false),
                                    style: boldTextStyle(size: 12)),
                              ],
                            ),
                            Divider(),
                            Column(
                              children: List.generate(
                                multiSelectStore.selectedService.length,
                                (index) {
                                  ServiceData data =
                                      multiSelectStore.selectedService[index];
                                  return Row(
                                    children: [
                                      Marquee(
                                              child: Text(data.name.validate(),
                                                  style: primaryTextStyle(
                                                      size: 14)))
                                          .expand(),
                                      PriceWidget(
                                          price: data.charges
                                              .validate()
                                              .toDouble()
                                              .toStringAsFixed(1),
                                          textSize: 14),
                                    ],
                                  ).paddingBottom(2);
                                },
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Text(locale.lblTotal,
                                        style: boldTextStyle(size: 14))
                                    .expand(),
                                PriceWidget(
                                    price: multiSelectStore.selectedService
                                        .sumByDouble(
                                            (p0) => p0.charges.toDouble())
                                        .toString(),
                                    textSize: 14),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if ((multiSelectStore.selectedService.isEmpty) &&
                        (isDoctor() || isReceptionist()))
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(locale.lblAddService,
                                style: secondaryTextStyle(
                                    color: appPrimaryColor, size: 10))
                            .paddingOnly(top: 10)
                            .onTap(
                              () => AddServiceScreen().launch(context),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                      )
                  ],
                );
              },
            ),
            16.height,
            AppointmentDateComponent(
                initialDate: isUpdate
                    ? DateFormat(SAVE_DATE_FORMAT).parse(
                        widget.data!.appointmentGlobalStartDate.validate())
                    : DateTime.now()),
            16.height,
            AppointmentSlots(
              date: isUpdate
                  ? widget.data?.getAppointmentSaveDate
                  : getAppointmentDate,
              clinicId: isUpdate
                  ? widget.data?.clinicId.validate()
                  : widget.clinicId.validate().toString(),
              doctorId: isUpdate
                  ? widget.data?.doctorId.validate()
                  : widget.doctorId.validate().toString(),
              appointmentTime:
                  isUpdate ? widget.data?.getAppointmentTime.validate() : '',
            ),
            16.height,
            AppTextField(
              maxLines: 15,
              minLines: 5,
              controller: descriptionCont,
              textInputAction: TextInputAction.done,
              focus: descFocus,
              isValidationRequired: false,
              textFieldType: TextFieldType.MULTILINE,
              decoration: inputDecoration(
                  context: context, labelText: locale.lblDescription),
            ),
            16.height,
            FileUploadComponent().paddingBottom(32),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: locale.lblBookAppointment,
        onTap: () async {
          appointmentAppStore.setDescription(descriptionCont.text);
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            bool? res = await showInDialog(
              context,
              barrierDismissible: false,
              backgroundColor: context.cardColor,
              builder: (p0) {
                return ConfirmAppointmentScreen(
                    appointmentId: widget.data?.id.toInt() ?? null);
              },
            );
            if (res ?? false) {}
          } else {
            isFirstTime = !isFirstTime;
            setState(() {});
          }
        },
      ).paddingAll(16),
    );
  }
}
