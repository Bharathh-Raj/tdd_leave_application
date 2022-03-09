import 'package:leave_application/features/leave_application/domain/leave_application.dart';

class LeaveApplicationModel extends LeaveApplication {
  LeaveApplicationModel(
      {required String id,
      required DateTime applyDate,
      required DateTime fromDate,
      DateTime? toDate,
      required String leaveType,
      String? reason})
      : super(
            id: id,
            applyDate: applyDate,
            fromDate: fromDate,
            toDate: toDate,
            leaveType: leaveType,
            reason: reason);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applyDate': applyDate,
      'fromDate': fromDate,
      'toDate': toDate,
      'leaveType': leaveType,
      'reason': reason,
    };
  }

  factory LeaveApplicationModel.fromMap(Map<String, dynamic> map) {
    DateTime? toDate = map['toDate'] != null ? DateTime.parse(map['toDate'] as String) : null;
    String? reason = map['reason'] != null ? map['reason'] as String : null;
    return LeaveApplicationModel(
      id: map['id'] as String,
      applyDate: DateTime.parse(map['applyDate'] as String),
      fromDate: DateTime.parse(map['fromDate'] as String),
      toDate: toDate,
      leaveType: map['leaveType'] as String,
      reason: reason,
    );
  }
}
