import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/fetch_leave_applications_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../data/test_helper/leave_data_test_helper.dart';

void main() {
  late FetchLeaveApplicationUseCase fetchLeaveApplicationUseCase;
  late LocalLeaveDataTestHelper helper;

  setUp(() {
    helper = LocalLeaveDataTestHelper();
    fetchLeaveApplicationUseCase =
        FetchLeaveApplicationUseCase(LeaveRepoImpl(LocalLeaveDSImpl(helper.mockBox)));
  });

  test("fetchLeaveApplications() method should be called from repo", () async {
    helper.setUpFetchSuccess();
    await fetchLeaveApplicationUseCase(null);
    verify(fetchLeaveApplicationUseCase.leaveRepo.fetchLeaveApplications()).called(1);
  });

  test("Return type should be of type Either<Failure, List<LeaveApplication>?>", () async {
    helper.setUpFetchSuccess();
    final result = await fetchLeaveApplicationUseCase(null);
    expect(result, isInstanceOf<Either<Failure, List<LeaveApplication>?>>());
  });

  group("Fetch success", () {
    test("isRight should be true on success", () async {
      helper.setUpFetchSuccess();
      final Either<Failure, List<LeaveApplication>?> result =
          await fetchLeaveApplicationUseCase(null);
      expect(result.isRight(), isTrue);
    });

    test("Return type should be Right<Failure, List<LeaveApplication>?> on success", () async {
      helper.setUpFetchSuccess();
      final Either<Failure, List<LeaveApplication>?> result =
          await fetchLeaveApplicationUseCase(null);
      expect(result, isInstanceOf<Right<Failure, List<LeaveApplication>?>>());
    });

    test("Should return null on no applications available", () async {
      helper.setUpFetchNull();
      final Either<Failure, List<LeaveApplication>?> result =
          await fetchLeaveApplicationUseCase(null);
      expect((result as Right<Failure, List<LeaveApplication>?>).value, isNull);
    });

    test("List<LeaveApplication> should be returned on success with some applications", () async {
      helper.setUpFetchSuccess();
      final Either<Failure, List<LeaveApplication>?> result =
          await fetchLeaveApplicationUseCase(null);
      expect((result as Right<Failure, List<LeaveApplication>?>).value,
          helper.leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList());
    });
  });
}
