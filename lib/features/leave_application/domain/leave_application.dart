import 'leave_type.dart';

class LeaveApplication {
  /// id is just the applied DateTime
  final String id;
  final DateTime fromDate;
  final DateTime? toDate;
  final String leaveType;
  final String reason;

  LeaveApplication({
    required this.id,
    required this.fromDate,
    this.toDate,
    required this.leaveType,
    required this.reason,
  }) : assert(LeaveType.values.contains(leaveType), "Leave type is not valid.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveApplication && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
