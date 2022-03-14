class LeaveType {
  LeaveType._();

  static String get casualLeave => "Casual Leave";
  static String get sickLeave => "Sick Leave";
  static String get compensatoryLeave => "Compensatory Leave";
  static String get unpaidLeave => "Unpaid Leave";

  static List<String> get values => [casualLeave, sickLeave, compensatoryLeave, unpaidLeave];
}
