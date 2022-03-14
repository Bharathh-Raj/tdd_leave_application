import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/apply_leave_use_case.dart';

import '../../../../../core/failure.dart';
import 'apply_leave_state.dart';

class ApplyLeaveCubit extends Cubit<ApplyLeaveState> {
  final ApplyLeaveUseCase applyLeaveUseCase;
  ApplyLeaveCubit({required this.applyLeaveUseCase}) : super(const ApplyLeaveState.initial());

  void applyLeave(LeaveApplication leaveApplication) async {
    emit(const ApplyLeaveState.loading());
    Either<Failure, void> result = await applyLeaveUseCase(leaveApplication);
    emit(result.fold((l) => ApplyLeaveState.failure(l), (r) => const ApplyLeaveState.success()));
  }
}
