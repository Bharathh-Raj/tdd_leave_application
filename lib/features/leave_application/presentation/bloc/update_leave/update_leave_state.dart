import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/failure.dart';

part 'update_leave_state.freezed.dart';

@freezed
class UpdateLeaveState with _$UpdateLeaveState {
  const factory UpdateLeaveState.initial() = _initial;
  const factory UpdateLeaveState.loading() = _loading;
  const factory UpdateLeaveState.success() = _success;
  const factory UpdateLeaveState.failure(Failure failure) = _failure;
}
