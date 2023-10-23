import 'package:solidcare/model/dashboard_model.dart';
import 'package:solidcare/model/static_data_model.dart';
import 'package:solidcare/model/upcoming_appointment_model.dart';
import 'package:solidcare/model/user_model.dart';
import 'package:solidcare/screens/patient/models/news_model.dart';

DashboardModel? cachedDashboardModel;
NewsModel? cachedNewsFeed;

List<UpcomingAppointmentModel>? cachedDoctorAppointment;
List<UpcomingAppointmentModel>? cachedReceptionistAppointment;
List<UpcomingAppointmentModel>? cachedPatientAppointment;

List<UserModel>? cachedDoctorPatient;
List<UserModel>? cachedClinicPatient;
List<UserModel>? cachedDoctorList;

UserModel? cachedUserData;
List<StaticData?>? cachedStaticData;
