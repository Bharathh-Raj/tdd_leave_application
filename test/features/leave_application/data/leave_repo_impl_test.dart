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
    LeaveApplication leaveApplication = LeaveApplication(
        id: DateTime.now(),
        leaveType: LeaveType.casualLeave,
        fromDate: DateTime(2022),
        toDate: DateTime(2023));

    test("applyLeave() method of localLeaveDS should be called", () async {
      localTestHelper.setUpApplySuccess();
      await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      verify(leaveRepoImpl.localLeaveDS
          .applyLeave(LeaveApplicationModel.fromParent(leaveApplication)));
    });

    test("Right should be returned on success", () async {
      localTestHelper.setUpApplySuccess();
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response.isRight(), isTrue);
    });

    test("Right<Unit> should be returned on success", () async {
      localTestHelper.setUpApplySuccess();
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response, isInstanceOf<Right<Failure, void>>());
    });

    test("Left should be returned on failure", () async {
      localTestHelper.setUpApplyFailure();
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response.isLeft(), isTrue);
    });

    test("Left<Failure> should be returned on failure", () async {
      localTestHelper.setUpApplyFailure();
      Either<Failure, void> response =
          await leaveRepoImpl.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      expect(response, isInstanceOf<Left<Failure, void>>());
    });
  });

  group("Delete Leave", () {
    LeaveApplication leaveApplication = LeaveApplication(
        id: DateTime.now(),
        leaveType: LeaveType.casualLeave,
        fromDate: DateTime(2022),
        toDate: DateTime(2023));

    test("deleteLeave() method from localLeaveDs instance should be called", () async {
      localTestHelper.setUpDeleteSuccess();
      await leaveRepoImpl.deleteLeave(leaveApplication);
      verify(leaveRepoImpl.localLeaveDS
          .deleteLeave(LeaveApplicationModel.fromParent(leaveApplication)));
    });

    test("Right should be returned on success", () async {
      localTestHelper.setUpDeleteSuccess();
      Either<Failure, void> result = await leaveRepoImpl.deleteLeave(leaveApplication);
      expect(result.isRight(), isTrue);
    });

    test("Right<void> should be returned on success", () async {
      localTestHelper.setUpDeleteSuccess();
      Either<Failure, void> result = await leaveRepoImpl.deleteLeave(leaveApplication);
      expect(result, isInstanceOf<Right<Failure, void>>());
    });

    test("Left should be returned on failure", () async {
      localTestHelper.setUpDeleteFailure();
      Either<Failure, void> result = await leaveRepoImpl.deleteLeave(leaveApplication);
      expect(result.isLeft(), isTrue);
    });

    test("Left<Failure> should be returned on failure", () async {
      localTestHelper.setUpDeleteFailure();
      Either<Failure, void> result = await leaveRepoImpl.deleteLeave(leaveApplication);
      expect(result, isInstanceOf<Left<Failure, void>>());
    });
  });

  group("Update Leave", () {
    LeaveApplication leaveApplication = LeaveApplication(
        id: DateTime.now(),
        leaveType: LeaveType.casualLeave,
        fromDate: DateTime(2022),
        toDate: DateTime(2023));

    test("updateLeave() method from localLeaveDs instance should be called", () async {
      localTestHelper.setUpUpdateSuccess();
      await leaveRepoImpl.updateLeave(leaveApplication);
      verify(leaveRepoImpl.localLeaveDS
          .updateLeave(LeaveApplicationModel.fromParent(leaveApplication)));
    });

    test("Right should be returned on success", () async {
      localTestHelper.setUpUpdateSuccess();
      Either<Failure, void> result = await leaveRepoImpl.updateLeave(leaveApplication);
      expect(result.isRight(), isTrue);
    });

    test("Right<void> should be returned on success", () async {
      localTestHelper.setUpUpdateSuccess();
      Either<Failure, void> result = await leaveRepoImpl.updateLeave(leaveApplication);
      expect(result, isInstanceOf<Right<Failure, void>>());
    });

    test("Left should be returned on failure", () async {
      localTestHelper.setUpUpdateFailure();
      Either<Failure, void> result = await leaveRepoImpl.updateLeave(leaveApplication);
      expect(result.isLeft(), isTrue);
    });

    test("Left<Failure> should be returned on failure", () async {
      localTestHelper.setUpUpdateFailure();
      Either<Failure, void> result = await leaveRepoImpl.updateLeave(leaveApplication);
      expect(result, isInstanceOf<Left<Failure, void>>());
    });
  });
}
