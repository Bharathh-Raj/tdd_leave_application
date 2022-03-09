import 'package:leave_application/features/leave_application/data/leave_application_model.dart';

abstract class LeaveDS {
  Future<void> applyLeave(LeaveApplicationModel leaveApplicationModel);
  Future<void> updateLeave(LeaveApplicationModel leaveApplicationModel);
  Future<void> deleteLeave(LeaveApplicationModel leaveApplicationModel);
  List<LeaveApplicationModel>? fetchLeaveApplications();
}
