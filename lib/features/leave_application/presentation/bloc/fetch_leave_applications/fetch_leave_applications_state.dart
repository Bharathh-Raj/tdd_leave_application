import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/failure.dart';
import '../../../domain/leave_application.dart';

part 'fetch_leave_applications_state.freezed.dart';

@freezed
class FetchLeaveApplicationsState with _$FetchLeaveApplicationsState {
  const factory FetchLeaveApplicationsState.loading() = _loading;
  const factory FetchLeaveApplicationsState.success(List<LeaveApplication>? leaveApplications) =
      _success;
  const factory FetchLeaveApplicationsState.failure(Failure failure) = _failure;
}
