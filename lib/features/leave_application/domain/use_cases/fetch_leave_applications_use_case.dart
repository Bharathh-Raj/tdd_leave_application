import 'package:dartz/dartz.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/core/use_case.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/leave_repo.dart';

class FetchLeaveApplicationUseCase extends UseCase<List<LeaveApplication>?, void> {
  final LeaveRepo leaveRepo;

  FetchLeaveApplicationUseCase(this.leaveRepo);

  @override
  Future<Either<Failure, List<LeaveApplication>?>> call(void param) async {
    return await leaveRepo.fetchLeaveApplications();
  }
}
