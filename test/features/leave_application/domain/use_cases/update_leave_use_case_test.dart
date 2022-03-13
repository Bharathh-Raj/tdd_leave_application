import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/Update_leave_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../data/test_helper/leave_data_test_helper.dart';

void main() {
  late UpdateLeaveUseCase updateLeaveUseCase;
  late LocalLeaveDataTestHelper helper;

  setUp(() {
    helper = LocalLeaveDataTestHelper();
    updateLeaveUseCase =
        UpdateLeaveUseCase(leaveRepo: LeaveRepoImpl(LocalLeaveDSImpl(helper.mockBox)));
  });

  test("Should call UpdateLeave() method from repository", () async {
    helper.setUpUpdateSuccess();
    await updateLeaveUseCase(helper.leaveApplication);
    verify(updateLeaveUseCase.leaveRepo.updateLeave(helper.leaveApplication)).called(1);
  });

  test("should be of type Either<Failure, void>", () async {
    helper.setUpUpdateSuccess();
    final result = await updateLeaveUseCase(helper.leaveApplication);
    expect(result, isInstanceOf<Either<Failure, void>>());
  });

  group("Update Leave Success", () {
    test("isRight should be true on success", () async {
      helper.setUpUpdateSuccess();
      Either<Failure, void> result = await updateLeaveUseCase(helper.leaveApplication);
      expect(result.isRight(), isTrue);
    });

    test("Right<Failure, void> should be returned on success", () async {
      helper.setUpUpdateSuccess();
      Either<Failure, void> result = await updateLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Right<Failure, void>>());
    });
  });

  group("Update Leave Failure", () {
    test("isLeft should be true on success", () async {
      helper.setUpUpdateFailure();
      Either<Failure, void> result = await updateLeaveUseCase(helper.leaveApplication);
      expect(result.isLeft(), isTrue);
    });

    test("Left<Failure, void> should be returned on success", () async {
      helper.setUpUpdateFailure();
      Either<Failure, void> result = await updateLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Left<Failure, void>>());
    });
  });
}
