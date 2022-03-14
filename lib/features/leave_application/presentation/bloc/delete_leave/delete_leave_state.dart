import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/failure.dart';

part 'delete_leave_state.freezed.dart';

@freezed
class DeleteLeaveState with _$DeleteLeaveState {
  const factory DeleteLeaveState.initial() = _initial;
  const factory DeleteLeaveState.loading() = _loading;
  const factory DeleteLeaveState.success() = _success;
  const factory DeleteLeaveState.failure(Failure failure) = _failure;
}
