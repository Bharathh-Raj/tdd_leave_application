import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/apply_leave_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../data/test_helper/leave_data_test_helper.dart';

void main() {
  late ApplyLeaveUseCase applyLeaveUseCase;
  late LocalLeaveDataTestHelper helper;

  setUp(() {
    helper = LocalLeaveDataTestHelper();
    applyLeaveUseCase =
        ApplyLeaveUseCase(leaveRepo: LeaveRepoImpl(LocalLeaveDSImpl(helper.mockBox)));
  });

  test("Should call applyLeave() method from repository", () async {
    helper.setUpApplySuccess();
    await applyLeaveUseCase(helper.leaveApplication);
    verify(applyLeaveUseCase.leaveRepo.applyLeave(helper.leaveApplication)).called(1);
  });

  test("should be of type Either<Failure, void>", () async {
    helper.setUpApplySuccess();
    final result = await applyLeaveUseCase(helper.leaveApplication);
    expect(result, isInstanceOf<Either<Failure, void>>());
  });

  group("Apply Leave Success", () {
    test("isRight should be true on success", () async {
      helper.setUpApplySuccess();
      Either<Failure, void> result = await applyLeaveUseCase(helper.leaveApplication);
      expect(result.isRight(), isTrue);
    });

    test("Right<Failure, void> should be returned on success", () async {
      helper.setUpApplySuccess();
      Either<Failure, void> result = await applyLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Right<Failure, void>>());
    });
  });

  group("Apply Leave Failure", () {
    test("isLeft should be true on success", () async {
      helper.setUpApplyFailure();
      Either<Failure, void> result = await applyLeaveUseCase(helper.leaveApplication);
      expect(result.isLeft(), isTrue);
    });

    test("Left<Failure, void> should be returned on success", () async {
      helper.setUpApplyFailure();
      Either<Failure, void> result = await applyLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Left<Failure, void>>());
    });
  });
}
