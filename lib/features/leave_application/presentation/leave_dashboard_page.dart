import 'package:flutter/material.dart';
import 'package:leave_application/core/constants/color_constants.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/BgContainer.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/curved_box.dart';
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
          const SliverToBoxAdapter(child: CurvedBox()),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return LeaveDetails(leaveApplication: leaveApplicationList[index]);
            },
            childCount: leaveApplicationList.length,
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 180,
        height: 68,
        padding: const EdgeInsets.only(bottom: 24),
        child: BgContainer(
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {},
            child: const Text("Apply for Leave"),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
        ),
      ),
    );
  }
}
