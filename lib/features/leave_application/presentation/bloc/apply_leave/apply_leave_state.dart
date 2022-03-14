import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/failure.dart';

part 'apply_leave_state.freezed.dart';

@freezed
class ApplyLeaveState with _$ApplyLeaveState {
  const factory ApplyLeaveState.initial() = _initial;
  const factory ApplyLeaveState.loading() = _loading;
  const factory ApplyLeaveState.success() = _success;
  const factory ApplyLeaveState.failure(Failure failure) = _failure;
}
