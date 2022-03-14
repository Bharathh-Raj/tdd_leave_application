import 'package:hive/hive.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/leave_ds.dart';

abstract class LocalLeaveDS implements LeaveDS {}

class LocalLeaveDSImpl implements LocalLeaveDS {
  final Box hiveBox;

  LocalLeaveDSImpl(this.hiveBox);

  @override
  Future<void> applyLeave(LeaveApplicationModel leaveApplicationModel) async {
    return await hiveBox.put(leaveApplicationModel.id.toString(), leaveApplicationModel.toMap());
  }

  @override
  Future<void> deleteLeave(LeaveApplicationModel leaveApplicationModel) async {
    return await hiveBox.delete(leaveApplicationModel.id.toString());
  }

  @override
  List<LeaveApplicationModel>? fetchLeaveApplications() {
    List<Map<String, dynamic>> leaveApplicationsMap =
        hiveBox.values.map((e) => Map<String, dynamic>.from(e)).toList().reversed.toList();

    if (leaveApplicationsMap.isEmpty) return null;

    List<LeaveApplicationModel> leaveApplications =
        leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList();
    return leaveApplications;
  }

  @override
  Future<void> updateLeave(LeaveApplicationModel leaveApplicationModel) async {
    return await hiveBox.put(leaveApplicationModel.id, leaveApplicationModel.toMap());
  }
}
