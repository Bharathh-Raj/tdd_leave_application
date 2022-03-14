import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';

import '../../../../../core/failure.dart';
import '../../../domain/use_cases/delete_leave_use_case.dart';
import 'delete_leave_state.dart';

class DeleteLeaveCubit extends Cubit<DeleteLeaveState> {
  final DeleteLeaveUseCase deleteLeaveUseCase;
  DeleteLeaveCubit({required this.deleteLeaveUseCase}) : super(const DeleteLeaveState.initial());

  void deleteLeave(LeaveApplication leaveApplication) async {
    emit(const DeleteLeaveState.loading());
    Either<Failure, void> result = await deleteLeaveUseCase(leaveApplication);
    emit(result.fold((l) => DeleteLeaveState.failure(l), (r) => const DeleteLeaveState.success()));
  }
}
