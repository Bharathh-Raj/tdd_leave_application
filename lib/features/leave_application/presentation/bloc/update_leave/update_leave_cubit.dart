import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';

import '../../../../../core/failure.dart';
import '../../../domain/use_cases/Update_leave_use_case.dart';
import 'update_leave_state.dart';

class UpdateLeaveCubit extends Cubit<UpdateLeaveState> {
  final UpdateLeaveUseCase updateLeaveUseCase;
  UpdateLeaveCubit({required this.updateLeaveUseCase}) : super(const UpdateLeaveState.initial());

  void updateLeave(LeaveApplication leaveApplication) async {
    emit(const UpdateLeaveState.loading());
    Either<Failure, void> result = await updateLeaveUseCase(leaveApplication);
    emit(result.fold((l) => UpdateLeaveState.failure(l), (r) => const UpdateLeaveState.success()));
  }
}
