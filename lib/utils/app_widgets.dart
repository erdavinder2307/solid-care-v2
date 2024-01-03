import 'package:solidcare/main.dart';
import 'package:solidcare/model/demo_login_model.dart';
import 'package:solidcare/model/upcoming_appointment_model.dart';
import 'package:solidcare/utils/constants.dart';

List<DemoLoginModel> demoLoginList() {
  List<DemoLoginModel> demoLoginListData = [];
  demoLoginListData
      .add(DemoLoginModel(loginTypeImage: "images/icons/user.png"));
  demoLoginListData
      .add(DemoLoginModel(loginTypeImage: "images/icons/receptionistIcon.png"));
  demoLoginListData
      .add(DemoLoginModel(loginTypeImage: "images/icons/doctorIcon.png"));

  return demoLoginListData;
}

List<String> bloodGroupList = [
  'A+',
  'B+',
  'AB+',
  'O+',
  'A-',
  'B-',
  'AB-',
  'O-'
];
List<String> userRoleList = [
  UserRoleDoctor,
  UserRolePatient,
  UserRoleReceptionist
];

List<WeeklyAppointment> emptyGraphListMonthly = [
  WeeklyAppointment(x: "W1", y: 0),
  WeeklyAppointment(x: "W2", y: 0),
  WeeklyAppointment(x: "W3", y: 0),
  WeeklyAppointment(x: "W4", y: 0),
  WeeklyAppointment(x: "W5", y: 0),
];

List<WeeklyAppointment> emptyGraphListYearly = [
  WeeklyAppointment(x: locale.lblJan, y: 0),
  WeeklyAppointment(x: locale.lblFeb, y: 0),
  WeeklyAppointment(x: locale.lblMar, y: 0),
  WeeklyAppointment(x: locale.lblApr, y: 0),
  WeeklyAppointment(x: locale.lblMay, y: 0),
  WeeklyAppointment(x: locale.lblJun, y: 0),
  WeeklyAppointment(x: locale.lblJul, y: 0),
  WeeklyAppointment(x: locale.lblAug, y: 0),
  WeeklyAppointment(x: locale.lblSep, y: 0),
  WeeklyAppointment(x: locale.lblOct, y: 0),
  WeeklyAppointment(x: locale.lblNov, y: 0),
  WeeklyAppointment(x: locale.lblDec, y: 0),
];
