import 'package:hive/hive.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/leave_ds.dart';

import '../../../core/fixture_reader.dart';

abstract class LocalLeaveDS implements LeaveDS {}

class LocalLeaveDSImpl implements LocalLeaveDS {
  final Box hiveBox;
  static const String _fetchKey = "FetchLeaveApplicationsKey";

  LocalLeaveDSImpl(this.hiveBox);

  @override
  Future<void> applyLeave(LeaveApplicationModel leaveApplicationModel) async {
    return await hiveBox.put(leaveApplicationModel.id, leaveApplicationModel.toMap());
  }

  @override
  Future<void> deleteLeave(LeaveApplicationModel leaveApplicationModel) async {
    // TODO: implement deleteLeave
  }

  @override
  List<LeaveApplicationModel>? fetchLeaveApplications() {
    final List<dynamic>? rawLeaveApplications = hiveBox.get(_fetchKey);
    List<Map<String, dynamic>>? leaveApplicationsMap =
        rawLeaveApplications?.map((e) => Map<String, dynamic>.from(e)).toList();

    if (leaveApplicationsMap == null) return null;

    List<LeaveApplicationModel> leaveApplications =
        leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList();
    return leaveApplications;
  }

  @override
  Future<void> updateLeave(LeaveApplicationModel leaveApplicationModel) async {
    // TODO: implement updateLeave
  }
}
