class UserPermission {
  AppointmentModule? appointmentModule;
  BillingModule? billingModule;
  ClinicModule? clinicModule;
  ClinicalDetailModule? clinicalDetailModule;
  DashboardModule? dashboardModule;
  DoctorModule? doctorModule;
  EncounterPermissionModule? encounterModule;
  EncountersTemplateModule? encountersTemplateModule;
  HolidayModule? holidayModule;
  OtherModule? otherModule;
  PatientModule? patientModule;
  ReportModule? patientReportModule;
  PrescriptionPermissionModule? prescriptionModule;
  ReceptionistModule? receptionistModule;
  ServiceModule? serviceModule;
  SessionModule? sessionModule;
  StaticDataModule? staticDataModule;

  UserPermission({
    this.appointmentModule,
    this.billingModule,
    this.clinicModule,
    this.clinicalDetailModule,
    this.dashboardModule,
    this.doctorModule,
    this.encounterModule,
    this.encountersTemplateModule,
    this.holidayModule,
    this.otherModule,
    this.patientModule,
    this.patientReportModule,
    this.prescriptionModule,
    this.receptionistModule,
    this.serviceModule,
    this.sessionModule,
    this.staticDataModule,
  });

  factory UserPermission.fromJson(Map<String, dynamic> json) => UserPermission(
        appointmentModule: json["appointment_module"] == null
            ? null
            : AppointmentModule.fromJson(json["appointment_module"]),
        billingModule: json["billing_module"] == null
            ? null
            : BillingModule.fromJson(json["billing_module"]),
        clinicModule: json["clinic_module"] == null
            ? null
            : ClinicModule.fromJson(json["clinic_module"]),
        clinicalDetailModule: json["clinical_detail_module"] == null
            ? null
            : ClinicalDetailModule.fromJson(json["clinical_detail_module"]),
        dashboardModule: json["dashboard_module"] == null
            ? null
            : DashboardModule.fromJson(json["dashboard_module"]),
        doctorModule: json["doctor_module"] == null
            ? null
            : DoctorModule.fromJson(json["doctor_module"]),
        encounterModule: json["encounter_module"] == null
            ? null
            : EncounterPermissionModule.fromJson(json["encounter_module"]),
        encountersTemplateModule: json["encounters_template_module"] == null
            ? null
            : EncountersTemplateModule.fromJson(
                json["encounters_template_module"]),
        holidayModule: json["holiday_module"] == null
            ? null
            : HolidayModule.fromJson(json["holiday_module"]),
        otherModule: json["other_module"] == null
            ? null
            : OtherModule.fromJson(json["other_module"]),
        patientModule: json["patient_module"] == null
            ? null
            : PatientModule.fromJson(json["patient_module"]),
        patientReportModule: json["patient_report_module"] == null
            ? null
            : ReportModule.fromJson(json["patient_report_module"]),
        prescriptionModule: json["prescription_module"] == null
            ? null
            : PrescriptionPermissionModule.fromJson(
                json["prescription_module"]),
        receptionistModule: json["receptionist_module"] == null
            ? null
            : ReceptionistModule.fromJson(json["receptionist_module"]),
        serviceModule: json["service_module"] == null
            ? null
            : ServiceModule.fromJson(json["service_module"]),
        sessionModule: json["session_module"] == null
            ? null
            : SessionModule.fromJson(json["session_module"]),
        staticDataModule: json["static_data_module"] == null
            ? null
            : StaticDataModule.fromJson(json["static_data_module"]),
      );

  Map<String, dynamic> toJson() => {
        "appointment_module": appointmentModule?.toJson(),
        "billing_module": billingModule?.toJson(),
        "clinic_module": clinicModule?.toJson(),
        "clinical_detail_module": clinicalDetailModule?.toJson(),
        "dashboard_module": dashboardModule?.toJson(),
        "doctor_module": doctorModule?.toJson(),
        "encounter_module": encounterModule?.toJson(),
        "encounters_template_module": encountersTemplateModule?.toJson(),
        "holiday_module": holidayModule?.toJson(),
        "other_module": otherModule?.toJson(),
        "patient_module": patientModule?.toJson(),
        "patient_report_module": patientReportModule?.toJson(),
        "prescription_module": prescriptionModule?.toJson(),
        "receptionist_module": receptionistModule?.toJson(),
        "service_module": serviceModule?.toJson(),
        "session_module": sessionModule?.toJson(),
        "static_data_module": staticDataModule?.toJson(),
      };
}

class AppointmentModule {
  bool? solidCareAppointmentList;
  bool? solidCareAppointmentAdd;
  bool? solidCareAppointmentEdit;
  bool? solidCareAppointmentView;
  bool? solidCareAppointmentDelete;
  bool? solidCarePatientAppointmentStatusChange;
  bool? solidCareAppointmentExport;

  AppointmentModule({
    this.solidCareAppointmentList,
    this.solidCareAppointmentAdd,
    this.solidCareAppointmentEdit,
    this.solidCareAppointmentView,
    this.solidCareAppointmentDelete,
    this.solidCarePatientAppointmentStatusChange,
    this.solidCareAppointmentExport,
  });

  factory AppointmentModule.fromJson(Map<String, dynamic> json) =>
      AppointmentModule(
        solidCareAppointmentList: json["solidCare_appointment_list"],
        solidCareAppointmentAdd: json["solidCare_appointment_add"],
        solidCareAppointmentEdit: json["solidCare_appointment_edit"],
        solidCareAppointmentView: json["solidCare_appointment_view"],
        solidCareAppointmentDelete: json["solidCare_appointment_delete"],
        solidCarePatientAppointmentStatusChange:
            json["solidCare_patient_appointment_status_change"],
        solidCareAppointmentExport: json["solidCare_appointment_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_appointment_list": solidCareAppointmentList,
        "solidCare_appointment_add": solidCareAppointmentAdd,
        "solidCare_appointment_edit": solidCareAppointmentEdit,
        "solidCare_appointment_view": solidCareAppointmentView,
        "solidCare_appointment_delete": solidCareAppointmentDelete,
        "solidCare_patient_appointment_status_change":
            solidCarePatientAppointmentStatusChange,
        "solidCare_appointment_export": solidCareAppointmentExport,
      };
}

class BillingModule {
  bool? solidCarePatientBillList;
  bool? solidCarePatientBillAdd;
  bool? solidCarePatientBillEdit;
  bool? solidCarePatientBillView;
  bool? solidCarePatientBillDelete;
  bool? solidCarePatientBillExport;

  BillingModule({
    this.solidCarePatientBillList,
    this.solidCarePatientBillAdd,
    this.solidCarePatientBillEdit,
    this.solidCarePatientBillView,
    this.solidCarePatientBillDelete,
    this.solidCarePatientBillExport,
  });

  factory BillingModule.fromJson(Map<String, dynamic> json) => BillingModule(
        solidCarePatientBillList: json["solidCare_patient_bill_list"],
        solidCarePatientBillAdd: json["solidCare_patient_bill_add"],
        solidCarePatientBillEdit: json["solidCare_patient_bill_edit"],
        solidCarePatientBillView: json["solidCare_patient_bill_view"],
        solidCarePatientBillDelete: json["solidCare_patient_bill_delete"],
        solidCarePatientBillExport: json["solidCare_patient_bill_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_patient_bill_list": solidCarePatientBillList,
        "solidCare_patient_bill_add": solidCarePatientBillAdd,
        "solidCare_patient_bill_edit": solidCarePatientBillEdit,
        "solidCare_patient_bill_view": solidCarePatientBillView,
        "solidCare_patient_bill_delete": solidCarePatientBillDelete,
        "solidCare_patient_bill_export": solidCarePatientBillExport,
      };
}

class ClinicModule {
  bool? solidCareClinicList;
  bool? solidCareClinicAdd;
  bool? solidCareClinicEdit;
  bool? solidCareClinicView;
  bool? solidCareClinicDelete;
  bool? solidCareClinicProfile;

  ClinicModule({
    this.solidCareClinicList,
    this.solidCareClinicAdd,
    this.solidCareClinicEdit,
    this.solidCareClinicView,
    this.solidCareClinicDelete,
    this.solidCareClinicProfile,
  });

  factory ClinicModule.fromJson(Map<String, dynamic> json) => ClinicModule(
        solidCareClinicList: json["solidCare_clinic_list"],
        solidCareClinicAdd: json["solidCare_clinic_add"],
        solidCareClinicEdit: json["solidCare_clinic_edit"],
        solidCareClinicView: json["solidCare_clinic_view"],
        solidCareClinicDelete: json["solidCare_clinic_delete"],
        solidCareClinicProfile: json["solidCare_clinic_profile"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_clinic_list": solidCareClinicList,
        "solidCare_clinic_add": solidCareClinicAdd,
        "solidCare_clinic_edit": solidCareClinicEdit,
        "solidCare_clinic_view": solidCareClinicView,
        "solidCare_clinic_delete": solidCareClinicDelete,
        "solidCare_clinic_profile": solidCareClinicProfile,
      };
}

class ClinicalDetailModule {
  bool? solidCareMedicalRecordsList;
  bool? solidCareMedicalRecordsAdd;
  bool? solidCareMedicalRecordsEdit;
  bool? solidCareMedicalRecordsView;
  bool? solidCareMedicalRecordsDelete;

  ClinicalDetailModule({
    this.solidCareMedicalRecordsList,
    this.solidCareMedicalRecordsAdd,
    this.solidCareMedicalRecordsEdit,
    this.solidCareMedicalRecordsView,
    this.solidCareMedicalRecordsDelete,
  });

  factory ClinicalDetailModule.fromJson(Map<String, dynamic> json) =>
      ClinicalDetailModule(
        solidCareMedicalRecordsList: json["solidCare_medical_records_list"],
        solidCareMedicalRecordsAdd: json["solidCare_medical_records_add"],
        solidCareMedicalRecordsEdit: json["solidCare_medical_records_edit"],
        solidCareMedicalRecordsView: json["solidCare_medical_records_view"],
        solidCareMedicalRecordsDelete: json["solidCare_medical_records_delete"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_medical_records_list": solidCareMedicalRecordsList,
        "solidCare_medical_records_add": solidCareMedicalRecordsAdd,
        "solidCare_medical_records_edit": solidCareMedicalRecordsEdit,
        "solidCare_medical_records_view": solidCareMedicalRecordsView,
        "solidCare_medical_records_delete": solidCareMedicalRecordsDelete,
      };
}

class DashboardModule {
  bool? solidCareDashboardTotalPatient;
  bool? solidCareDashboardTotalDoctor;
  bool? solidCareDashboardTotalAppointment;
  bool? solidCareDashboardTotalRevenue;

  bool? solidCareDashboardTotalTodayAppointment;

  bool? solidCareDashboardTotalService;

  DashboardModule({
    this.solidCareDashboardTotalPatient,
    this.solidCareDashboardTotalDoctor,
    this.solidCareDashboardTotalAppointment,
    this.solidCareDashboardTotalRevenue,
    this.solidCareDashboardTotalService,
    this.solidCareDashboardTotalTodayAppointment,
  });

  factory DashboardModule.fromJson(Map<String, dynamic> json) =>
      DashboardModule(
        solidCareDashboardTotalPatient:
            json["solidCare_dashboard_total_patient"],
        solidCareDashboardTotalDoctor: json["solidCare_dashboard_total_doctor"],
        solidCareDashboardTotalAppointment:
            json["solidCare_dashboard_total_appointment"],
        solidCareDashboardTotalRevenue:
            json["solidCare_dashboard_total_revenue"],
        solidCareDashboardTotalService:
            json['solidCare_dashboard_total_service'],
        solidCareDashboardTotalTodayAppointment:
            json['solidCare_dashboard_total_today_appointment'],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_dashboard_total_patient": solidCareDashboardTotalPatient,
        "solidCare_dashboard_total_doctor": solidCareDashboardTotalDoctor,
        "solidCare_dashboard_total_appointment":
            solidCareDashboardTotalAppointment,
        "solidCare_dashboard_total_revenue": solidCareDashboardTotalRevenue,
      };
}

class DoctorModule {
  bool? solidCareDoctorDashboard;
  bool? solidCareDoctorList;
  bool? solidCareDoctorAdd;
  bool? solidCareDoctorEdit;
  bool? solidCareDoctorView;
  bool? solidCareDoctorDelete;
  bool? solidCareDoctorExport;

  DoctorModule({
    this.solidCareDoctorDashboard,
    this.solidCareDoctorList,
    this.solidCareDoctorAdd,
    this.solidCareDoctorEdit,
    this.solidCareDoctorView,
    this.solidCareDoctorDelete,
    this.solidCareDoctorExport,
  });

  factory DoctorModule.fromJson(Map<String, dynamic> json) => DoctorModule(
        solidCareDoctorDashboard: json["solidCare_doctor_dashboard"],
        solidCareDoctorList: json["solidCare_doctor_list"],
        solidCareDoctorAdd: json["solidCare_doctor_add"],
        solidCareDoctorEdit: json["solidCare_doctor_edit"],
        solidCareDoctorView: json["solidCare_doctor_view"],
        solidCareDoctorDelete: json["solidCare_doctor_delete"],
        solidCareDoctorExport: json["solidCare_doctor_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_doctor_dashboard": solidCareDoctorDashboard,
        "solidCare_doctor_list": solidCareDoctorList,
        "solidCare_doctor_add": solidCareDoctorAdd,
        "solidCare_doctor_edit": solidCareDoctorEdit,
        "solidCare_doctor_view": solidCareDoctorView,
        "solidCare_doctor_delete": solidCareDoctorDelete,
        "solidCare_doctor_export": solidCareDoctorExport,
      };
}

class EncounterPermissionModule {
  bool? solidCarePatientEncounters;
  bool? solidCarePatientEncounterList;
  bool? solidCarePatientEncounterAdd;
  bool? solidCarePatientEncounterEdit;
  bool? solidCarePatientEncounterView;
  bool? solidCarePatientEncounterDelete;
  bool? solidCarePatientEncounterExport;

  EncounterPermissionModule({
    this.solidCarePatientEncounters,
    this.solidCarePatientEncounterList,
    this.solidCarePatientEncounterAdd,
    this.solidCarePatientEncounterEdit,
    this.solidCarePatientEncounterView,
    this.solidCarePatientEncounterDelete,
    this.solidCarePatientEncounterExport,
  });

  factory EncounterPermissionModule.fromJson(Map<String, dynamic> json) =>
      EncounterPermissionModule(
        solidCarePatientEncounters: json["solidCare_patient_encounters"],
        solidCarePatientEncounterList: json["solidCare_patient_encounter_list"],
        solidCarePatientEncounterAdd: json["solidCare_patient_encounter_add"],
        solidCarePatientEncounterEdit: json["solidCare_patient_encounter_edit"],
        solidCarePatientEncounterView: json["solidCare_patient_encounter_view"],
        solidCarePatientEncounterDelete:
            json["solidCare_patient_encounter_delete"],
        solidCarePatientEncounterExport:
            json["solidCare_patient_encounter_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_patient_encounters": solidCarePatientEncounters,
        "solidCare_patient_encounter_list": solidCarePatientEncounterList,
        "solidCare_patient_encounter_add": solidCarePatientEncounterAdd,
        "solidCare_patient_encounter_edit": solidCarePatientEncounterEdit,
        "solidCare_patient_encounter_view": solidCarePatientEncounterView,
        "solidCare_patient_encounter_delete": solidCarePatientEncounterDelete,
        "solidCare_patient_encounter_export": solidCarePatientEncounterExport,
      };
}

class EncountersTemplateModule {
  bool? solidCareEncountersTemplateList;
  bool? solidCareEncountersTemplateAdd;
  bool? solidCareEncountersTemplateEdit;
  bool? solidCareEncountersTemplateView;
  bool? solidCareEncountersTemplateDelete;

  EncountersTemplateModule({
    this.solidCareEncountersTemplateList,
    this.solidCareEncountersTemplateAdd,
    this.solidCareEncountersTemplateEdit,
    this.solidCareEncountersTemplateView,
    this.solidCareEncountersTemplateDelete,
  });

  factory EncountersTemplateModule.fromJson(Map<String, dynamic> json) =>
      EncountersTemplateModule(
        solidCareEncountersTemplateList:
            json["solidCare_encounters_template_list"],
        solidCareEncountersTemplateAdd:
            json["solidCare_encounters_template_add"],
        solidCareEncountersTemplateEdit:
            json["solidCare_encounters_template_edit"],
        solidCareEncountersTemplateView:
            json["solidCare_encounters_template_view"],
        solidCareEncountersTemplateDelete:
            json["solidCare_encounters_template_delete"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_encounters_template_list": solidCareEncountersTemplateList,
        "solidCare_encounters_template_add": solidCareEncountersTemplateAdd,
        "solidCare_encounters_template_edit": solidCareEncountersTemplateEdit,
        "solidCare_encounters_template_view": solidCareEncountersTemplateView,
        "solidCare_encounters_template_delete":
            solidCareEncountersTemplateDelete,
      };
}

class HolidayModule {
  bool? solidCareClinicSchedule;
  bool? solidCareClinicScheduleAdd;
  bool? solidCareClinicScheduleEdit;
  bool? solidCareClinicScheduleDelete;
  bool? solidCareClinicScheduleExport;

  HolidayModule({
    this.solidCareClinicSchedule,
    this.solidCareClinicScheduleAdd,
    this.solidCareClinicScheduleEdit,
    this.solidCareClinicScheduleDelete,
    this.solidCareClinicScheduleExport,
  });

  factory HolidayModule.fromJson(Map<String, dynamic> json) => HolidayModule(
        solidCareClinicSchedule: json["solidCare_clinic_schedule"],
        solidCareClinicScheduleAdd: json["solidCare_clinic_schedule_add"],
        solidCareClinicScheduleEdit: json["solidCare_clinic_schedule_edit"],
        solidCareClinicScheduleDelete: json["solidCare_clinic_schedule_delete"],
        solidCareClinicScheduleExport: json["solidCare_clinic_schedule_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_clinic_schedule": solidCareClinicSchedule,
        "solidCare_clinic_schedule_add": solidCareClinicScheduleAdd,
        "solidCare_clinic_schedule_edit": solidCareClinicScheduleEdit,
        "solidCare_clinic_schedule_delete": solidCareClinicScheduleDelete,
        "solidCare_clinic_schedule_export": solidCareClinicScheduleExport,
      };
}

class OtherModule {
  bool? solidCareSettings;
  bool? solidCareDashboard;
  bool? solidCareChangePassword;
  bool? solidCareHomePage;
  bool? solidCarePatientReviewAdd;
  bool? solidCarePatientReviewEdit;
  bool? solidCarePatientReviewDelete;
  bool? solidCarePatientReviewGet;

  OtherModule({
    this.solidCareSettings,
    this.solidCareDashboard,
    this.solidCareChangePassword,
    this.solidCareHomePage,
    this.solidCarePatientReviewAdd,
    this.solidCarePatientReviewEdit,
    this.solidCarePatientReviewDelete,
    this.solidCarePatientReviewGet,
  });

  factory OtherModule.fromJson(Map<String, dynamic> json) => OtherModule(
        solidCareSettings: json["solidCare_settings"],
        solidCareDashboard: json["solidCare_dashboard"],
        solidCareChangePassword: json["solidCare_change_password"],
        solidCareHomePage: json["solidCare_home_page"],
        solidCarePatientReviewAdd: json["solidCare_patient_review_add"],
        solidCarePatientReviewEdit: json["solidCare_patient_review_edit"],
        solidCarePatientReviewDelete: json["solidCare_patient_review_delete"],
        solidCarePatientReviewGet: json["solidCare_patient_review_get"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_settings": solidCareSettings,
        "solidCare_dashboard": solidCareDashboard,
        "solidCare_change_password": solidCareChangePassword,
        "solidCare_home_page": solidCareHomePage,
        "solidCare_patient_review_add": solidCarePatientReviewAdd,
        "solidCare_patient_review_edit": solidCarePatientReviewEdit,
        "solidCare_patient_review_delete": solidCarePatientReviewDelete,
        "solidCare_patient_review_get": solidCarePatientReviewGet,
      };
}

class PatientModule {
  bool? solidCarePatientList;
  bool? solidCarePatientAdd;
  bool? solidCarePatientEdit;
  bool? solidCarePatientView;
  bool? solidCarePatientDelete;
  bool? solidCarePatientClinic;
  bool? solidCarePatientExport;

  bool? solidCarePatientProfile;

  PatientModule({
    this.solidCarePatientList,
    this.solidCarePatientAdd,
    this.solidCarePatientEdit,
    this.solidCarePatientView,
    this.solidCarePatientDelete,
    this.solidCarePatientClinic,
    this.solidCarePatientExport,
    this.solidCarePatientProfile,
  });

  factory PatientModule.fromJson(Map<String, dynamic> json) => PatientModule(
      solidCarePatientList: json["solidCare_patient_list"],
      solidCarePatientAdd: json["solidCare_patient_add"],
      solidCarePatientEdit: json["solidCare_patient_edit"],
      solidCarePatientView: json["solidCare_patient_view"],
      solidCarePatientDelete: json["solidCare_patient_delete"],
      solidCarePatientClinic: json["solidCare_patient_clinic"],
      solidCarePatientExport: json["solidCare_patient_export"],
      solidCarePatientProfile: json['solidCare_patient_profile']);

  Map<String, dynamic> toJson() => {
        "solidCare_patient_list": solidCarePatientList,
        "solidCare_patient_add": solidCarePatientAdd,
        "solidCare_patient_edit": solidCarePatientEdit,
        "solidCare_patient_view": solidCarePatientView,
        "solidCare_patient_delete": solidCarePatientDelete,
        "solidCare_patient_clinic": solidCarePatientClinic,
        "solidCare_patient_export": solidCarePatientExport,
      };
}

class ReportModule {
  bool? solidCarePatientReport;
  bool? solidCarePatientReportAdd;
  bool? solidCarePatientReportView;
  bool? solidCarePatientReportDelete;
  bool? solidCarePatientReportEdit;

  ReportModule({
    this.solidCarePatientReport,
    this.solidCarePatientReportAdd,
    this.solidCarePatientReportView,
    this.solidCarePatientReportDelete,
    this.solidCarePatientReportEdit,
  });

  factory ReportModule.fromJson(Map<String, dynamic> json) => ReportModule(
        solidCarePatientReport: json["solidCare_patient_report"],
        solidCarePatientReportAdd: json["solidCare_patient_report_add"],
        solidCarePatientReportView: json["solidCare_patient_report_view"],
        solidCarePatientReportDelete: json["solidCare_patient_report_delete"],
        solidCarePatientReportEdit: json["solidCare_patient_report_edit"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_patient_report": solidCarePatientReport,
        "solidCare_patient_report_add": solidCarePatientReportAdd,
        "solidCare_patient_report_view": solidCarePatientReportView,
        "solidCare_patient_report_delete": solidCarePatientReportDelete,
        "solidCare_patient_report_edit": solidCarePatientReportEdit,
      };
}

class PrescriptionPermissionModule {
  bool? solidCarePrescriptionList;
  bool? solidCarePrescriptionAdd;
  bool? solidCarePrescriptionEdit;
  bool? solidCarePrescriptionView;
  bool? solidCarePrescriptionDelete;
  bool? solidCarePrescriptionExport;

  PrescriptionPermissionModule({
    this.solidCarePrescriptionList,
    this.solidCarePrescriptionAdd,
    this.solidCarePrescriptionEdit,
    this.solidCarePrescriptionView,
    this.solidCarePrescriptionDelete,
    this.solidCarePrescriptionExport,
  });

  factory PrescriptionPermissionModule.fromJson(Map<String, dynamic> json) =>
      PrescriptionPermissionModule(
        solidCarePrescriptionList: json["solidCare_prescription_list"],
        solidCarePrescriptionAdd: json["solidCare_prescription_add"],
        solidCarePrescriptionEdit: json["solidCare_prescription_edit"],
        solidCarePrescriptionView: json["solidCare_prescription_view"],
        solidCarePrescriptionDelete: json["solidCare_prescription_delete"],
        solidCarePrescriptionExport: json["solidCare_prescription_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_prescription_list": solidCarePrescriptionList,
        "solidCare_prescription_add": solidCarePrescriptionAdd,
        "solidCare_prescription_edit": solidCarePrescriptionEdit,
        "solidCare_prescription_view": solidCarePrescriptionView,
        "solidCare_prescription_delete": solidCarePrescriptionDelete,
        "solidCare_prescription_export": solidCarePrescriptionExport,
      };
}

class ReceptionistModule {
  bool? solidCareReceptionistProfile;

  ReceptionistModule({
    this.solidCareReceptionistProfile,
  });

  factory ReceptionistModule.fromJson(Map<String, dynamic> json) =>
      ReceptionistModule(
        solidCareReceptionistProfile: json["solidCare_receptionist_profile"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_receptionist_profile": solidCareReceptionistProfile,
      };
}

class ServiceModule {
  bool? solidCareServiceList;
  bool? solidCareServiceAdd;
  bool? solidCareServiceEdit;
  bool? solidCareServiceView;
  bool? solidCareServiceDelete;
  bool? solidCareServiceExport;

  ServiceModule({
    this.solidCareServiceList,
    this.solidCareServiceAdd,
    this.solidCareServiceEdit,
    this.solidCareServiceView,
    this.solidCareServiceDelete,
    this.solidCareServiceExport,
  });

  factory ServiceModule.fromJson(Map<String, dynamic> json) => ServiceModule(
        solidCareServiceList: json["solidCare_service_list"],
        solidCareServiceAdd: json["solidCare_service_add"],
        solidCareServiceEdit: json["solidCare_service_edit"],
        solidCareServiceView: json["solidCare_service_view"],
        solidCareServiceDelete: json["solidCare_service_delete"],
        solidCareServiceExport: json["solidCare_service_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_service_list": solidCareServiceList,
        "solidCare_service_add": solidCareServiceAdd,
        "solidCare_service_edit": solidCareServiceEdit,
        "solidCare_service_view": solidCareServiceView,
        "solidCare_service_delete": solidCareServiceDelete,
        "solidCare_service_export": solidCareServiceExport,
      };
}

class SessionModule {
  bool? solidCareDoctorSessionList;
  bool? solidCareDoctorSessionAdd;
  bool? solidCareDoctorSessionEdit;
  bool? solidCareDoctorSessionDelete;
  bool? solidCareDoctorSessionExport;

  SessionModule({
    this.solidCareDoctorSessionList,
    this.solidCareDoctorSessionAdd,
    this.solidCareDoctorSessionEdit,
    this.solidCareDoctorSessionDelete,
    this.solidCareDoctorSessionExport,
  });

  factory SessionModule.fromJson(Map<String, dynamic> json) => SessionModule(
        solidCareDoctorSessionList: json["solidCare_doctor_session_list"],
        solidCareDoctorSessionAdd: json["solidCare_doctor_session_add"],
        solidCareDoctorSessionEdit: json["solidCare_doctor_session_edit"],
        solidCareDoctorSessionDelete: json["solidCare_doctor_session_delete"],
        solidCareDoctorSessionExport: json["solidCare_doctor_session_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_doctor_session_list": solidCareDoctorSessionList,
        "solidCare_doctor_session_add": solidCareDoctorSessionAdd,
        "solidCare_doctor_session_edit": solidCareDoctorSessionEdit,
        "solidCare_doctor_session_delete": solidCareDoctorSessionDelete,
        "solidCare_doctor_session_export": solidCareDoctorSessionExport,
      };
}

class StaticDataModule {
  bool? solidCareStaticDataList;
  bool? solidCareStaticDataAdd;
  bool? solidCareStaticDataEdit;
  bool? solidCareStaticDataView;
  bool? solidCareStaticDataDelete;
  bool? solidCareStaticDataExport;

  StaticDataModule({
    this.solidCareStaticDataList,
    this.solidCareStaticDataAdd,
    this.solidCareStaticDataEdit,
    this.solidCareStaticDataView,
    this.solidCareStaticDataDelete,
    this.solidCareStaticDataExport,
  });

  factory StaticDataModule.fromJson(Map<String, dynamic> json) =>
      StaticDataModule(
        solidCareStaticDataList: json["solidCare_static_data_list"],
        solidCareStaticDataAdd: json["solidCare_static_data_add"],
        solidCareStaticDataEdit: json["solidCare_static_data_edit"],
        solidCareStaticDataView: json["solidCare_static_data_view"],
        solidCareStaticDataDelete: json["solidCare_static_data_delete"],
        solidCareStaticDataExport: json["solidCare_static_data_export"],
      );

  Map<String, dynamic> toJson() => {
        "solidCare_static_data_list": solidCareStaticDataList,
        "solidCare_static_data_add": solidCareStaticDataAdd,
        "solidCare_static_data_edit": solidCareStaticDataEdit,
        "solidCare_static_data_view": solidCareStaticDataView,
        "solidCare_static_data_delete": solidCareStaticDataDelete,
        "solidCare_static_data_export": solidCareStaticDataExport,
      };
}
