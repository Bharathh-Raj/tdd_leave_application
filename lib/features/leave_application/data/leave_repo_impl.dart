import 'package:dartz/dartz.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/leave_repo.dart';

class LeaveRepoImpl implements LeaveRepo {
  final LocalLeaveDS localLeaveDS;
  //TODO: Add Remote DS

  LeaveRepoImpl(this.localLeaveDS);

  @override
  Future<Either<Failure, void>> applyLeave(LeaveApplication leaveApplication) async {
    try {
      await localLeaveDS.applyLeave(LeaveApplicationModel.fromParent(leaveApplication));
      return const Right(null);
    } catch (e) {
      return Left(Failure(messageToDisplay: "Apply Leave Failed", errorObject: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLeave(LeaveApplication leaveApplication) async {
    try {
      await localLeaveDS.deleteLeave(LeaveApplicationModel.fromParent(leaveApplication));
      return const Right(null);
    } catch (e) {
      return Left(Failure(messageToDisplay: "Delete Leave Failed", errorObject: e));
    }
  }

  @override
  Future<Either<Failure, List<LeaveApplication>?>> fetchLeaveApplications() {
    try {
      List<LeaveApplication>? leaveApplications = localLeaveDS.fetchLeaveApplications();
      return Future.value(Right(leaveApplications));
    } catch (e) {
      return Future.value(
          Left(Failure(messageToDisplay: "Fetch Leave Applications Failed", errorObject: e)));
    }
  }

  @override
  Future<Either<Failure, void>> updateLeave(LeaveApplication leaveApplication) async {
    try {
      await localLeaveDS.updateLeave(LeaveApplicationModel.fromParent(leaveApplication));
      return const Right(null);
    } catch (e) {
      return Left(Failure(messageToDisplay: "Update Leave Failed", errorObject: e));
    }
  }
}
