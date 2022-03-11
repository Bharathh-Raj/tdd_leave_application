import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leave_application/core/constants/string_constants.dart';
import 'package:leave_application/features/leave_application/presentation/leave_dashboard_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      theme: ThemeData.dark(),
      home: const LeaveDashboardPage(),
    );
  }
}
