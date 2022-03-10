import 'package:dartz/dartz.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';

import '../../../core/failure.dart';

abstract class LeaveRepo {
  Future<Either<Failure, void>> applyLeave(LeaveApplication leaveApplication);
  Future<Either<Failure, void>> updateLeave(LeaveApplication leaveApplication);
  Future<Either<Failure, void>> deleteLeave(LeaveApplication leaveApplication);
  Future<Either<Failure, List<LeaveApplication>?>> fetchLeaveApplications();
}
