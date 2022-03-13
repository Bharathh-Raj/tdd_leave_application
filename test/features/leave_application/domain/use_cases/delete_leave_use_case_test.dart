import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/delete_leave_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../data/test_helper/leave_data_test_helper.dart';

void main() {
  late DeleteLeaveUseCase deleteLeaveUseCase;
  late LocalLeaveDataTestHelper helper;

  setUp(() {
    helper = LocalLeaveDataTestHelper();
    deleteLeaveUseCase =
        DeleteLeaveUseCase(leaveRepo: LeaveRepoImpl(LocalLeaveDSImpl(helper.mockBox)));
  });

  test("Should call DeleteLeave() method from repository", () async {
    helper.setUpDeleteSuccess();
    await deleteLeaveUseCase(helper.leaveApplication);
    verify(deleteLeaveUseCase.leaveRepo.deleteLeave(helper.leaveApplication)).called(1);
  });

  test("should be of type Either<Failure, void>", () async {
    helper.setUpDeleteSuccess();
    final result = await deleteLeaveUseCase(helper.leaveApplication);
    expect(result, isInstanceOf<Either<Failure, void>>());
  });

  group("Delete Leave Success", () {
    test("isRight should be true on success", () async {
      helper.setUpDeleteSuccess();
      Either<Failure, void> result = await deleteLeaveUseCase(helper.leaveApplication);
      expect(result.isRight(), isTrue);
    });

    test("Right<Failure, void> should be returned on success", () async {
      helper.setUpDeleteSuccess();
      Either<Failure, void> result = await deleteLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Right<Failure, void>>());
    });
  });

  group("Delete Leave Failure", () {
    test("isLeft should be true on success", () async {
      helper.setUpDeleteFailure();
      Either<Failure, void> result = await deleteLeaveUseCase(helper.leaveApplication);
      expect(result.isLeft(), isTrue);
    });

    test("Left<Failure, void> should be returned on success", () async {
      helper.setUpDeleteFailure();
      Either<Failure, void> result = await deleteLeaveUseCase(helper.leaveApplication);
      expect(result, isInstanceOf<Left<Failure, void>>());
    });
  });
}
