import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/fetch_leave_applications_use_case.dart';

import '../../../../../core/failure.dart';
import '../../../domain/leave_application.dart';
import 'fetch_leave_applications_state.dart';

class FetchLeaveApplicationsCubit extends Cubit<FetchLeaveApplicationsState> {
  final FetchLeaveApplicationUseCase fetchLeaveApplicationUseCase;

  FetchLeaveApplicationsCubit({required this.fetchLeaveApplicationUseCase})
      : super(const FetchLeaveApplicationsState.loading()) {
    fetchLeaveApplications();
  }

  void fetchLeaveApplications() async {
    emit(const FetchLeaveApplicationsState.loading());
    Either<Failure, List<LeaveApplication>?> result = await fetchLeaveApplicationUseCase(null);
    emit(result.fold((l) => FetchLeaveApplicationsState.failure(l),
        (r) => FetchLeaveApplicationsState.success(r)));
  }
}
