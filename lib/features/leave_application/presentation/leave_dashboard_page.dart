import 'package:flutter/material.dart';
import 'package:leave_application/core/constants/color_constants.dart';
import 'package:leave_application/core/constants/space_constants.dart';
import 'package:leave_application/core/constants/string_constants.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/bg_paint.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/dashboard_appbar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_progress_bar.dart';

class LeaveDashboardPage extends StatelessWidget {
  const LeaveDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: CustomScrollView(
          slivers: [
            const DashboardAppbar(),
            SliverToBoxAdapter(
                child: Container(
              height: 24,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: ColorConstants.bgColor),
            )),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ColoredBox(
                  color: ColorConstants.bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.cyan,
                      height: 40,
                    ),
                  ),
                );
              },
              childCount: 40,
            )),
          ],
        ));
  }
}
