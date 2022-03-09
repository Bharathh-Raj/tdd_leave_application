import 'leave_type.dart';

abstract class LeaveApplication {
  final String id;
  final DateTime applyDate;
  final DateTime fromDate;
  final DateTime? toDate;
  final String leaveType;
  final String? reason;

  LeaveApplication({
    required this.id,
    required this.applyDate,
    required this.fromDate,
    this.toDate,
    required this.leaveType,
    this.reason,
  }) : assert(LeaveType.values.contains(leaveType), "Leave type is not valid.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveApplication && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
