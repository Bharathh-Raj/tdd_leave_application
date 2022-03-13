import 'package:dartz/dartz.dart';
import 'package:leave_application/core/failure.dart';
import 'package:leave_application/core/use_case.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/leave_repo.dart';

class ApplyLeaveUseCase implements UseCase<void, LeaveApplication> {
  final LeaveRepo leaveRepo;

  ApplyLeaveUseCase({required this.leaveRepo});

  @override
  Future<Either<Failure, void>> call(LeaveApplication leaveApplication) async {
    return await leaveRepo.applyLeave(leaveApplication);
  }
}
