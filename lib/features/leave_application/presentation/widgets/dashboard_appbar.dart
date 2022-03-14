import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/core/constants/color_constants.dart';
import 'package:leave_application/features/leave_application/presentation/bloc/fetch_leave_applications/export.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/custom_drawer.dart';

import '../../../../core/constants/space_constants.dart';
import '../../../../core/constants/string_constants.dart';
import 'bg_paint.dart';
import 'leave_progress_bar.dart';

class DashboardAppbar extends StatelessWidget {
  const DashboardAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      collapsedHeight: 40,
      toolbarHeight: 40,
      backgroundColor: ColorConstants.primaryColor,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxHeight == 40 + MediaQuery.of(context).padding.top
              ? const Padding(
                  padding: SpaceConstants.overallPadding,
                  child: Center(child: CollapsedAppBar()),
                )
              : FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: CustomPaint(
                    painter: BGPainter(),
                    child: SafeArea(
                      child: Padding(
                        padding: SpaceConstants.overallPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CollapsedAppBar(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Good Morning, Bharath",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  StringConstants.leaveDashboard,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                            BlocBuilder<FetchLeaveApplicationsCubit, FetchLeaveApplicationsState>(
                                builder: (context, state) {
                              return state.maybeMap(
                                  orElse: () => const SizedBox(),
                                  success: (successState) {
                                    return LeaveProgressBar(
                                      currentLeaveCount:
                                          successState.leaveApplications?.length ?? 0,
                                      maxLeaveCount: 12,
                                    );
                                  });
                              // return
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class CollapsedAppBar extends StatelessWidget {
  const CollapsedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomPaint(
              size: const Size(20, 12),
              painter: CustomDrawer(),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              "Home",
              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
            ),
          ],
        ),
        const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ],
    );
  }
}
