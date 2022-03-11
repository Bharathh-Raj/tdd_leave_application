import 'package:flutter/material.dart';
import 'package:leave_application/core/constants/color_constants.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/dashboard_appbar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_details.dart';

class LeaveDashboardPage extends StatelessWidget {
  final List<LeaveApplication> leaveApplicationList = [
    LeaveApplication(
        id: DateTime.now(),
        fromDate: DateTime(2022, 3, 11),
        toDate: DateTime(2022, 3, 13),
        leaveType: "Sick Leave",
        reason: "Fever"),
    LeaveApplication(
        id: DateTime.now(),
        fromDate: DateTime(2022, 3, 1),
        toDate: DateTime(2022, 3, 2),
        leaveType: "Unpaid Leave",
        reason: "Rest"),
    LeaveApplication(
        id: DateTime.now(),
        fromDate: DateTime(2022, 3, 1),
        toDate: DateTime(2022, 3, 2),
        leaveType: "Unpaid Leave",
        reason: "Rest")
  ];
  LeaveDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const DashboardAppbar(),
        SliverToBoxAdapter(
            child: ColoredBox(
          color: ColorConstants.primaryColor,
          child: Container(
            height: 24,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: ColorConstants.bgColor),
          ),
        )),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return LeaveDetails(leaveApplication: leaveApplicationList[index]);
          },
          childCount: leaveApplicationList.length,
        )),
      ],
    ));
  }
}
