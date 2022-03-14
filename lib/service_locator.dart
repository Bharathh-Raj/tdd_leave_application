import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:leave_application/features/leave_application/data/leave_repo_impl.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:leave_application/features/leave_application/domain/leave_repo.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/apply_leave_use_case.dart';
import 'package:leave_application/features/leave_application/domain/use_cases/fetch_leave_applications_use_case.dart';
import 'package:path_provider/path_provider.dart';

import 'features/leave_application/domain/use_cases/Update_leave_use_case.dart';
import 'features/leave_application/domain/use_cases/delete_leave_use_case.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt _locator = GetIt.I;

  static Future<void> init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final Box hiveBox = await Hive.openBox('LeaveApplicationBox');
    _locator.registerLazySingleton<LocalLeaveDS>(() => LocalLeaveDSImpl(hiveBox));
    _locator.registerLazySingleton<LeaveRepo>(() => LeaveRepoImpl(_locator()));
    _locator
        .registerLazySingleton<ApplyLeaveUseCase>(() => ApplyLeaveUseCase(leaveRepo: _locator()));
    _locator
        .registerLazySingleton<UpdateLeaveUseCase>(() => UpdateLeaveUseCase(leaveRepo: _locator()));
    _locator
        .registerLazySingleton<DeleteLeaveUseCase>(() => DeleteLeaveUseCase(leaveRepo: _locator()));
    _locator.registerLazySingleton<FetchLeaveApplicationUseCase>(
        () => FetchLeaveApplicationUseCase(_locator()));
  }

  static Future<void> dispose() async {
    //TODO: bind dispose method
    await Hive.close();
  }
}
