import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leave_application/core/constants/string_constants.dart';
import 'package:leave_application/features/leave_application/presentation/leave_dashboard_page.dart';
import 'package:leave_application/service_locator.dart';

import 'features/leave_application/presentation/bloc/fetch_leave_applications/fetch_leave_applications_cubit.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchLeaveApplicationsCubit>(
      create: (context) => FetchLeaveApplicationsCubit(fetchLeaveApplicationUseCase: GetIt.I()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.appTitle,
        home: LeaveDashboardPage(),
      ),
    );
  }
}
