import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/leave_type.dart';
import 'package:mockito/mockito.dart';

import 'test_helper/leave_data_test_helper.dart';

void main() {
  late LocalLeaveDataTestHelper localTestHelper;
  late LeaveRepoImpl leaveRepoImpl;

  setUp(() {
    localTestHelper = LocalLeaveDataTestHelper();
    leaveRepoImpl = LeaveRepoImpl(LocalLeaveDSImpl(localTestHelper.mockBox));
  });

  group("Apply Leave", () {
    late LeaveApplication leaveApplication;
    setUp(() async {
      localTestHelper.setUpApplySuccess();
      leaveApplication = LeaveApplication(
          id: DateTime.now(),
          leaveType: LeaveType.casualLeave,
          fromDate: DateTime(2022),
          toDate: DateTime(2023));
    });

    test("applyLeave() method of localLeaveDS should be called", () async {
      await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      verify(leaveRepoImpl.localLeaveDS
          .applyLeave(LeaveApplicationModel.fromParent(leaveApplication)));
    });

    test("Right should be returned on success", () async {
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response.isRight(), isTrue);
    });

    test("Right<Unit> should be returned on success", () async {
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response, isInstanceOf<Right<Failure, void>>());
    });
  });
}
