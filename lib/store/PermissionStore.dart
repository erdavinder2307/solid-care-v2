import 'package:solidcare/model/user_permission.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'PermissionStore.g.dart';

class PermissionStore = PermissionStoreBase with _$PermissionStore;

abstract class PermissionStoreBase with Store {
  @observable
  bool isPermissionSettings = false;
  @observable
  UserPermission? userPermission;

  @observable
  AppointmentModule appointmentPermission = AppointmentModule(
    solidCareAppointmentAdd: true,
    solidCareAppointmentDelete: true,
    solidCareAppointmentEdit: true,
    solidCareAppointmentList: true,
    solidCareAppointmentView: true,
    solidCarePatientAppointmentStatusChange: isPatient() ? false : true,
    solidCareAppointmentExport: true,
  );

  @observable
  BillingModule billingPermission = BillingModule(
      solidCarePatientBillAdd: isPatient() ? false : true,
      solidCarePatientBillDelete: isPatient() ? false : true,
      solidCarePatientBillEdit: isPatient() ? false : true,
      solidCarePatientBillList: true,
      solidCarePatientBillExport: true,
      solidCarePatientBillView: true);

  @observable
  ClinicModule clinicPermission = ClinicModule(
    solidCareClinicAdd: isDoctor() ? true : false,
    solidCareClinicDelete: true,
    solidCareClinicEdit: true,
    solidCareClinicList: true,
    solidCareClinicProfile: true,
    solidCareClinicView: true,
  );

  @observable
  ClinicalDetailModule clinicDetailPermission = ClinicalDetailModule(
    solidCareMedicalRecordsAdd: isPatient() ? false : true,
    solidCareMedicalRecordsDelete: isPatient() ? false : true,
    solidCareMedicalRecordsEdit: isPatient() ? false : true,
    solidCareMedicalRecordsList: true,
    solidCareMedicalRecordsView: true,
  );

  @observable
  DashboardModule dashboardPermission = DashboardModule(
    solidCareDashboardTotalAppointment: true,
    solidCareDashboardTotalDoctor: true,
    solidCareDashboardTotalPatient: true,
    solidCareDashboardTotalRevenue: true,
    solidCareDashboardTotalTodayAppointment: true,
    solidCareDashboardTotalService: true,
  );

  @observable
  DoctorModule doctorPermission = DoctorModule(
    solidCareDoctorAdd: isReceptionist() ? true : false,
    solidCareDoctorDelete: isReceptionist() ? true : false,
    solidCareDoctorEdit: isPatient() ? false : true,
    solidCareDoctorDashboard: true,
    solidCareDoctorList: true,
    solidCareDoctorView: true,
    solidCareDoctorExport: true,
  );

  @observable
  EncounterPermissionModule encounterPermission = EncounterPermissionModule(
    solidCarePatientEncounterAdd: isPatient() ? false : true,
    solidCarePatientEncounterDelete: isPatient() ? false : true,
    solidCarePatientEncounterEdit: isPatient() ? false : true,
    solidCarePatientEncounterExport: true,
    solidCarePatientEncounterList: true,
    solidCarePatientEncounters: true,
    solidCarePatientEncounterView: true,
  );

  @observable
  EncountersTemplateModule encountersTemplatePermission =
      EncountersTemplateModule(
    solidCareEncountersTemplateAdd: true,
    solidCareEncountersTemplateDelete: true,
    solidCareEncountersTemplateEdit: true,
    solidCareEncountersTemplateList: true,
    solidCareEncountersTemplateView: true,
  );

  @observable
  HolidayModule holidayPermission = HolidayModule(
    solidCareClinicSchedule: true,
    solidCareClinicScheduleAdd: true,
    solidCareClinicScheduleDelete: true,
    solidCareClinicScheduleEdit: true,
    solidCareClinicScheduleExport: true,
  );

  SessionModule sessionPermission = SessionModule(
    solidCareDoctorSessionAdd: isPatient() ? false : true,
    solidCareDoctorSessionEdit: isPatient() ? false : true,
    solidCareDoctorSessionList: isPatient() ? false : true,
    solidCareDoctorSessionDelete: isDoctor() ? true : false,
    solidCareDoctorSessionExport: true,
  );
  @observable
  OtherModule otherPermission = OtherModule(
    solidCareChangePassword: true,
    solidCarePatientReviewAdd: isPatient() ? true : false,
    solidCarePatientReviewDelete: isPatient() ? true : false,
    solidCarePatientReviewEdit: isPatient() ? true : false,
    solidCarePatientReviewGet: true,
    solidCareDashboard: true,
  );

  @observable
  PatientModule patientPermission = PatientModule(
    solidCarePatientAdd: isPatient() ? false : true,
    solidCarePatientDelete: isPatient() ? false : true,
    solidCarePatientClinic: isPatient() ? true : false,
    solidCarePatientProfile: true,
    solidCarePatientEdit: true,
    solidCarePatientList: true,
    solidCarePatientExport: true,
    solidCarePatientView: true,
  );

  ReceptionistModule receptionistPermission =
      ReceptionistModule(solidCareReceptionistProfile: true);
  @observable
  ReportModule reportPermission = ReportModule(
    solidCarePatientReport: true,
    solidCarePatientReportAdd: true,
    solidCarePatientReportEdit: true,
    solidCarePatientReportView: true,
    solidCarePatientReportDelete: isPatient() ? false : true,
  );

  @observable
  PrescriptionPermissionModule prescriptionPermission =
      PrescriptionPermissionModule(
    solidCarePrescriptionAdd: isPatient() ? false : true,
    solidCarePrescriptionDelete: isPatient() ? false : true,
    solidCarePrescriptionEdit: isPatient() ? false : true,
    solidCarePrescriptionView: true,
    solidCarePrescriptionList: true,
    solidCarePrescriptionExport: true,
  );

  @observable
  ServiceModule servicePermission = ServiceModule(
    solidCareServiceAdd: isPatient() ? false : true,
    solidCareServiceDelete: isPatient() ? false : true,
    solidCareServiceEdit: isPatient() ? false : true,
    solidCareServiceExport: true,
    solidCareServiceList: true,
    solidCareServiceView: true,
  );

  @observable
  StaticDataModule staticDataPermission = StaticDataModule(
    solidCareStaticDataAdd: isPatient() ? false : true,
    solidCareStaticDataDelete: isPatient() ? false : true,
    solidCareStaticDataEdit: isPatient() ? false : true,
    solidCareStaticDataExport: true,
    solidCareStaticDataList: true,
    solidCareStaticDataView: true,
  );

  void setPermissionSettings(bool isAllowed) {
    isPermissionSettings = isAllowed;
  }

  void setUserPermission(UserPermission? permission) {
    if (permission != null)
      userPermission = permission;
    else
      userPermission = UserPermission(
        appointmentModule: appointmentPermission,
        billingModule: billingPermission,
        clinicModule: clinicPermission,
        clinicalDetailModule: clinicDetailPermission,
        dashboardModule: dashboardPermission,
        doctorModule: doctorPermission,
        encounterModule: encounterPermission,
        encountersTemplateModule: encountersTemplatePermission,
        holidayModule: holidayPermission,
        otherModule: otherPermission,
        patientModule: patientPermission,
        patientReportModule: reportPermission,
        prescriptionModule: prescriptionPermission,
        receptionistModule: receptionistPermission,
        serviceModule: servicePermission,
        sessionModule: sessionPermission,
        staticDataModule: staticDataPermission,
      );
    setValue(USER_PERMISSION, permission?.toJson());
  }

  void setAppointmentModulePermission(
      AppointmentModule? appointmentModulePermission) {
    if (appointmentModulePermission != null) {
      appointmentPermission = appointmentModulePermission;
    }
    setValue(SharedPreferenceKey.solidCareAppointmentAddKey,
        appointmentPermission.solidCareAppointmentAdd);
    setValue(SharedPreferenceKey.solidCareAppointmentDeleteKey,
        appointmentPermission.solidCareAppointmentDelete);
    setValue(SharedPreferenceKey.solidCareAppointmentEditKey,
        appointmentPermission.solidCareAppointmentEdit);
    setValue(SharedPreferenceKey.solidCareAppointmentListKey,
        appointmentPermission.solidCareAppointmentList);
    setValue(SharedPreferenceKey.solidCareAppointmentViewKey,
        appointmentPermission.solidCareAppointmentView);
    setValue(SharedPreferenceKey.solidCarePatientAppointmentStatusChangeKey,
        appointmentPermission.solidCarePatientAppointmentStatusChange);
    setValue(SharedPreferenceKey.solidCareAppointmentExportKey,
        appointmentPermission.solidCareAppointmentExport);
  }

  void setBillingModulePermission(BillingModule? billingModulePermission) {
    if (billingModulePermission != null) {
      billingPermission = billingModulePermission;
    }
    setValue(SharedPreferenceKey.solidCarePatientBillAddKey,
        billingPermission.solidCarePatientBillAdd);
    setValue(SharedPreferenceKey.solidCarePatientBillDeleteKey,
        billingPermission.solidCarePatientBillDelete);
    setValue(SharedPreferenceKey.solidCarePatientBillEditKey,
        billingPermission.solidCarePatientBillEdit);
    setValue(SharedPreferenceKey.solidCarePatientBillListKey,
        billingPermission.solidCarePatientBillList);
    setValue(SharedPreferenceKey.solidCarePatientBillExportKey,
        billingPermission.solidCarePatientBillExport);
    setValue(SharedPreferenceKey.solidCarePatientBillViewKey,
        billingPermission.solidCarePatientBillView);
  }

  void setClinicModulePermission(ClinicModule? clinicModulePermission) {
    if (clinicModulePermission != null)
      clinicPermission = clinicModulePermission;

    setValue(SharedPreferenceKey.solidCareClinicAddKey,
        clinicPermission.solidCareClinicAdd);
    setValue(SharedPreferenceKey.solidCareClinicDeleteKey,
        clinicPermission.solidCareClinicDelete);
    setValue(SharedPreferenceKey.solidCareClinicEditKey,
        clinicPermission.solidCareClinicEdit);
    setValue(SharedPreferenceKey.solidCareClinicListKey,
        clinicPermission.solidCareClinicList);
    setValue(SharedPreferenceKey.solidCareClinicProfileKey,
        clinicPermission.solidCareClinicProfile);
    setValue(SharedPreferenceKey.solidCareClinicViewKey,
        clinicPermission.solidCareClinicView);
  }

  void setClinicDetailModulePermission(
      ClinicalDetailModule? clinicalDetailModulePermission) {
    if (clinicalDetailModulePermission != null)
      clinicDetailPermission = clinicalDetailModulePermission;

    setValue(SharedPreferenceKey.solidCareMedicalRecordsAddKey,
        clinicDetailPermission.solidCareMedicalRecordsAdd);
    setValue(SharedPreferenceKey.solidCareMedicalRecordsDeleteKey,
        clinicDetailPermission.solidCareMedicalRecordsDelete);
    setValue(SharedPreferenceKey.solidCareMedicalRecordsEditKey,
        clinicDetailPermission.solidCareMedicalRecordsEdit);
    setValue(SharedPreferenceKey.solidCareMedicalRecordsListKey,
        clinicDetailPermission.solidCareMedicalRecordsList);
    setValue(SharedPreferenceKey.solidCareMedicalRecordsViewKey,
        clinicDetailPermission.solidCareMedicalRecordsView);
  }

  void setDoctorDashboardPermission(
      DashboardModule? dashboardModulePermission) {
    if (dashboardModulePermission != null)
      dashboardPermission = dashboardModulePermission;
    setValue(SharedPreferenceKey.solidCareDashboardTotalAppointmentKey,
        dashboardPermission.solidCareDashboardTotalAppointment);
    setValue(SharedPreferenceKey.solidCareDashboardTotalDoctorKey,
        dashboardPermission.solidCareDashboardTotalDoctor);
    setValue(SharedPreferenceKey.solidCareDashboardTotalPatientKey,
        dashboardPermission.solidCareDashboardTotalPatient);
    setValue(SharedPreferenceKey.solidCareDashboardTotalRevenueKey,
        dashboardPermission.solidCareDashboardTotalRevenue);
    setValue(SharedPreferenceKey.solidCareDashboardTotalTodayAppointmentKey,
        dashboardPermission.solidCareDashboardTotalTodayAppointment);
    setValue(SharedPreferenceKey.solidCareDashboardTotalServiceKey,
        dashboardPermission.solidCareDashboardTotalService);
  }

  void setDoctorModulePermission(DoctorModule? doctorModulePermission) {
    if (doctorModulePermission != null)
      doctorPermission = doctorModulePermission;
    setValue(SharedPreferenceKey.solidCareDoctorAddKey,
        doctorPermission.solidCareDoctorAdd);
    setValue(SharedPreferenceKey.solidCareDoctorDeleteKey,
        doctorPermission.solidCareDoctorDelete);
    setValue(SharedPreferenceKey.solidCareDoctorEditKey,
        doctorPermission.solidCareDoctorEdit);
    setValue(SharedPreferenceKey.solidCareDoctorDashboardKey,
        doctorPermission.solidCareDoctorDashboard);
    setValue(SharedPreferenceKey.solidCareDoctorListKey,
        doctorPermission.solidCareDoctorList);
    setValue(SharedPreferenceKey.solidCareDoctorViewKey,
        doctorPermission.solidCareDoctorView);
    setValue(SharedPreferenceKey.solidCareDoctorExportKey,
        doctorPermission.solidCareDoctorExport);
  }

  void setEncounterModulePermission(
      EncounterPermissionModule? encounterPermissionModule) {
    if (encounterPermissionModule != null)
      encounterPermission = encounterPermissionModule;
    setValue(SharedPreferenceKey.solidCarePatientEncounterAddKey,
        encounterPermission.solidCarePatientEncounterAdd);
    setValue(SharedPreferenceKey.solidCarePatientEncounterDeleteKey,
        encounterPermission.solidCarePatientEncounterDelete);
    setValue(SharedPreferenceKey.solidCarePatientEncounterEditKey,
        encounterPermission.solidCarePatientEncounterEdit);
    setValue(SharedPreferenceKey.solidCarePatientEncounterExportKey,
        encounterPermission.solidCarePatientEncounterExport);
    setValue(SharedPreferenceKey.solidCarePatientEncounterListKey,
        encounterPermission.solidCarePatientEncounterList);
    setValue(SharedPreferenceKey.solidCarePatientEncountersKey,
        encounterPermission.solidCarePatientEncounters);
    setValue(SharedPreferenceKey.solidCarePatientEncounterViewKey,
        encounterPermission.solidCarePatientEncounterView);
  }

  void setEncounterTemplateModulePermission(
      EncountersTemplateModule? encounterTemplateModulePermission) {
    if (encounterTemplateModulePermission != null)
      encountersTemplatePermission = encounterTemplateModulePermission;
    setValue(SharedPreferenceKey.solidCareEncountersTemplateAddKey,
        encountersTemplatePermission.solidCareEncountersTemplateAdd);
    setValue(SharedPreferenceKey.solidCareEncountersTemplateDeleteKey,
        encountersTemplatePermission.solidCareEncountersTemplateDelete);
    setValue(SharedPreferenceKey.solidCareEncountersTemplateEditKey,
        encountersTemplatePermission.solidCareEncountersTemplateEdit);
    setValue(SharedPreferenceKey.solidCareEncountersTemplateListKey,
        encountersTemplatePermission.solidCareEncountersTemplateList);
    setValue(SharedPreferenceKey.solidCareEncountersTemplateViewKey,
        encountersTemplatePermission.solidCareEncountersTemplateView);
  }

  void setHolidayModulePermission(HolidayModule? holidayModulePermission) {
    if (holidayModulePermission != null)
      holidayPermission = holidayModulePermission;
    setValue(SharedPreferenceKey.solidCareClinicScheduleKey,
        holidayPermission.solidCareClinicSchedule);
    setValue(SharedPreferenceKey.solidCareClinicScheduleAddKey,
        holidayPermission.solidCareClinicScheduleAdd);
    setValue(SharedPreferenceKey.solidCareClinicScheduleDeleteKey,
        holidayPermission.solidCareClinicScheduleDelete);
    setValue(SharedPreferenceKey.solidCareClinicScheduleEditKey,
        holidayPermission.solidCareClinicScheduleEdit);
    setValue(SharedPreferenceKey.solidCareClinicScheduleExportKey,
        holidayPermission.solidCareClinicScheduleExport);
  }

  void setSessionPermission(SessionModule? sessionModulePermission) {
    if (sessionModulePermission != null)
      sessionPermission = sessionModulePermission;
    setValue(SharedPreferenceKey.solidCareDoctorSessionAddKey,
        sessionPermission.solidCareDoctorSessionAdd);
    setValue(SharedPreferenceKey.solidCareDoctorSessionEditKey,
        sessionPermission.solidCareDoctorSessionEdit);
    setValue(SharedPreferenceKey.solidCareDoctorSessionListKey,
        sessionPermission.solidCareDoctorSessionList);
    setValue(SharedPreferenceKey.solidCareDoctorSessionDeleteKey,
        sessionPermission.solidCareDoctorSessionDelete);
    setValue(SharedPreferenceKey.solidCareDoctorSessionExportKey,
        sessionPermission.solidCareDoctorSessionExport);
  }

  void setOtherModulePermission(OtherModule? otherModulePermission) {
    if (otherModulePermission != null) otherPermission = otherModulePermission;
    setValue(SharedPreferenceKey.solidCareChangePasswordKey,
        otherPermission.solidCareChangePassword);
    setValue(SharedPreferenceKey.solidCarePatientReviewAddKey,
        otherPermission.solidCarePatientReviewAdd);
    setValue(SharedPreferenceKey.solidCarePatientReviewDeleteKey,
        otherPermission.solidCarePatientReviewDelete);
    setValue(SharedPreferenceKey.solidCarePatientReviewEditKey,
        otherPermission.solidCarePatientReviewEdit);
    setValue(SharedPreferenceKey.solidCarePatientReviewGetKey,
        otherPermission.solidCarePatientReviewGet);
    setValue(SharedPreferenceKey.solidCareDashboardKey,
        otherPermission.solidCareDashboard);
  }

  void setPatientModulePermission(PatientModule? patientModulePermission) {
    if (patientModulePermission != null)
      patientPermission = patientModulePermission;
    setValue(SharedPreferenceKey.solidCarePatientAddKey,
        patientPermission.solidCarePatientAdd);
    setValue(SharedPreferenceKey.solidCarePatientDeleteKey,
        patientPermission.solidCarePatientDelete);
    setValue(SharedPreferenceKey.solidCarePatientClinicKey,
        patientPermission.solidCarePatientClinic);
    setValue(SharedPreferenceKey.solidCarePatientProfileKey,
        patientPermission.solidCarePatientProfile);
    setValue(SharedPreferenceKey.solidCarePatientEditKey,
        patientPermission.solidCarePatientEdit);
    setValue(SharedPreferenceKey.solidCarePatientListKey,
        patientPermission.solidCarePatientList);
    setValue(SharedPreferenceKey.solidCarePatientExportKey,
        patientPermission.solidCarePatientExport);
    setValue(SharedPreferenceKey.solidCarePatientViewKey,
        patientPermission.solidCarePatientView);
  }

  void setReceptionistModule(ReceptionistModule? receptionistModulePermission) {
    if (receptionistModulePermission != null)
      receptionistPermission = receptionistModulePermission;
    setValue(SharedPreferenceKey.solidCareReceptionistProfileKey,
        receptionistPermission);
  }

  void setPatientReportModulePermission(ReportModule? reportModulePermission) {
    if (reportModulePermission != null) {
      reportPermission = reportModulePermission;
    }
    setValue(SharedPreferenceKey.solidCarePatientReportKey,
        reportPermission.solidCarePatientReport);
    setValue(SharedPreferenceKey.solidCarePatientReportAddKey,
        reportPermission.solidCarePatientReportAdd);
    setValue(SharedPreferenceKey.solidCarePatientReportEditKey,
        reportPermission.solidCarePatientReportEdit);
    setValue(SharedPreferenceKey.solidCarePatientReportViewKey,
        reportPermission.solidCarePatientReportView);
    setValue(SharedPreferenceKey.solidCarePatientReportDeleteKey,
        reportPermission.solidCarePatientReportDelete);
  }

  void setPrescriptionModulePermission(
      PrescriptionPermissionModule? prescriptionModulePermission) {
    if (prescriptionModulePermission != null)
      prescriptionPermission = prescriptionModulePermission;
    setValue(SharedPreferenceKey.solidCarePrescriptionAddKey,
        prescriptionPermission.solidCarePrescriptionAdd);
    setValue(SharedPreferenceKey.solidCarePrescriptionDeleteKey,
        prescriptionPermission.solidCarePrescriptionDelete);
    setValue(SharedPreferenceKey.solidCarePrescriptionEditKey,
        prescriptionPermission.solidCarePrescriptionEdit);
    setValue(SharedPreferenceKey.solidCarePrescriptionViewKey,
        prescriptionPermission.solidCarePrescriptionView);
    setValue(SharedPreferenceKey.solidCarePrescriptionListKey,
        prescriptionPermission.solidCarePrescriptionList);
    setValue(SharedPreferenceKey.solidCarePrescriptionExportKey,
        prescriptionPermission.solidCarePrescriptionExport);
  }

  void setServiceModulePermission(ServiceModule? serviceModulePermission) {
    if (serviceModulePermission != null)
      servicePermission = serviceModulePermission;
    setValue(SharedPreferenceKey.solidCareServiceAddKey,
        servicePermission.solidCareServiceAdd);
    setValue(SharedPreferenceKey.solidCareServiceDeleteKey,
        servicePermission.solidCareServiceDelete);
    setValue(SharedPreferenceKey.solidCareServiceEditKey,
        servicePermission.solidCareServiceEdit);
    setValue(SharedPreferenceKey.solidCareServiceExportKey,
        servicePermission.solidCareServiceExport);
    setValue(SharedPreferenceKey.solidCareServiceListKey,
        servicePermission.solidCareServiceList);
    setValue(SharedPreferenceKey.solidCareServiceViewKey,
        servicePermission.solidCareServiceView);
  }

  void setStaticDataModulePermission(
      StaticDataModule? staticDataModulePermission) {
    if (staticDataModulePermission != null) {
      staticDataPermission = staticDataModulePermission;
    }
    setValue(SharedPreferenceKey.solidCareStaticDataAddKey,
        staticDataPermission.solidCareStaticDataAdd);
    setValue(SharedPreferenceKey.solidCareStaticDataDeleteKey,
        staticDataPermission.solidCareStaticDataDelete);
    setValue(SharedPreferenceKey.solidCareStaticDataEditKey,
        staticDataPermission.solidCareStaticDataEdit);
    setValue(SharedPreferenceKey.solidCareStaticDataExportKey,
        staticDataPermission.solidCareStaticDataExport);
    setValue(SharedPreferenceKey.solidCareStaticDataListKey,
        staticDataPermission.solidCareStaticDataList);
    setValue(SharedPreferenceKey.solidCareStaticDataViewKey,
        staticDataPermission.solidCareStaticDataView);
  }
}
