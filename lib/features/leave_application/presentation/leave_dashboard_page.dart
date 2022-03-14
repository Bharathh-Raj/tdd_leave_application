import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/presentation/bloc/apply_leave/export.dart';
import 'package:leave_application/features/leave_application/presentation/leave_apply_page.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/BgContainer.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/curved_box.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/dashboard_appbar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_details.dart';

import 'bloc/fetch_leave_applications/export.dart';
import 'bloc/update_leave/export.dart';

class LeaveDashboardPage extends StatelessWidget {
  const LeaveDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const DashboardAppbar(),
          const SliverToBoxAdapter(child: CurvedBox()),
          BlocBuilder<FetchLeaveApplicationsCubit, FetchLeaveApplicationsState>(
            builder: (context, state) {
              return state.map(loading: (value) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }, success: (successState) {
                final List<LeaveApplication>? applicationsList = successState.leaveApplications;
                if (applicationsList == null) {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text("There are no leave applications")));
                }
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider<UpdateLeaveCubit>(
                                create: (context) =>
                                    UpdateLeaveCubit(updateLeaveUseCase: GetIt.I()),
                                child: LeaveApplyPage(
                                  currentLeaveApplication: applicationsList[index],
                                )),
                          ));
                        },
                        child: LeaveDetails(leaveApplication: applicationsList[index]));
                  },
                  childCount: applicationsList.length,
                ));
              }, failure: (failureState) {
                return SliverToBoxAdapter(
                    child: Center(child: Text(failureState.failure.messageToDisplay)));
              });
            },
          ),
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider<ApplyLeaveCubit>(
                    create: (context) => ApplyLeaveCubit(applyLeaveUseCase: GetIt.I()),
                    child: const LeaveApplyPage()),
              ));
            },
            child: const Text("Apply for Leave"),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
        ),
      ),
    );
  }
}
