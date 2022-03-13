import 'package:leave_application/features/leave_application/domain/leave_application.dart';

class LeaveApplicationModel extends LeaveApplication {
  LeaveApplicationModel(
      {required DateTime id,
      required DateTime fromDate,
      DateTime? toDate,
      required String leaveType,
      required String reason})
      : super(id: id, fromDate: fromDate, toDate: toDate, leaveType: leaveType, reason: reason);

  factory LeaveApplicationModel.fromParent(LeaveApplication leaveApplication) {
    return LeaveApplicationModel(
        id: leaveApplication.id,
        fromDate: leaveApplication.fromDate,
        leaveType: leaveApplication.leaveType,
        toDate: leaveApplication.toDate,
        reason: leaveApplication.reason);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromDate': fromDate,
      'toDate': toDate,
      'leaveType': leaveType,
      'reason': reason,
    };
  }

  factory LeaveApplicationModel.fromMap(Map<String, dynamic> map) {
    DateTime? toDate = map['toDate'] != null ? DateTime.parse(map['toDate'] as String) : null;
    return LeaveApplicationModel(
      id: DateTime.parse(map['id'] as String),
      fromDate: DateTime.parse(map['fromDate'] as String),
      toDate: toDate,
      leaveType: map['leaveType'] as String,
      reason: map['reason'] as String,
    );
  }
}
