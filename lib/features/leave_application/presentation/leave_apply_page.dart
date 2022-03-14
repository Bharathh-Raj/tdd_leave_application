import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/presentation/bloc/apply_leave/apply_leave_cubit.dart';
import 'package:leave_application/features/leave_application/presentation/bloc/delete_leave/delete_leave_cubit.dart';
import 'package:leave_application/features/leave_application/presentation/bloc/update_leave/update_leave_cubit.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/bg_paint.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/curved_box.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/custom_button.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/custom_calendar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_reason.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_type_widget.dart';

import '../../../core/constants/color_constants.dart';
import '../domain/leave_type.dart';
import 'bloc/fetch_leave_applications/fetch_leave_applications_cubit.dart';

class LeaveApplyPage extends StatefulWidget {
  final LeaveApplication? currentLeaveApplication;
  const LeaveApplyPage({Key? key, this.currentLeaveApplication}) : super(key: key);

  @override
  State<LeaveApplyPage> createState() => _LeaveApplyPageState();
}

class _LeaveApplyPageState extends State<LeaveApplyPage> {
  final _formKey = GlobalKey<FormState>();
  late final List<int> _yearList;

  late DateTime calendarMonth;
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? leaveType;
  String? leaveReason;

  @override
  void initState() {
    selectedFromDate = widget.currentLeaveApplication?.fromDate;
    selectedToDate = widget.currentLeaveApplication?.toDate;
    leaveReason = widget.currentLeaveApplication?.reason;
    leaveType = widget.currentLeaveApplication?.leaveType ?? LeaveType.values.first;
    calendarMonth = selectedFromDate != null
        ? DateTime(selectedFromDate!.year, selectedFromDate!.month)
        : DateTime.now();
    _yearList = List.generate(20, (index) => DateTime.now().year + index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<FetchLeaveApplicationsCubit>().fetchLeaveApplications();
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomPaint(
                    painter: BGPainter(),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<FetchLeaveApplicationsCubit>()
                                            .fetchLeaveApplications();
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.arrow_back_ios_rounded)),
                                  DropdownButton<String>(
                                    items: months
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Center(
                                              child: Text(
                                                e,
                                              ),
                                            )))
                                        .toList(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
                                    dropdownColor: Colors.blueAccent,
                                    value: months[calendarMonth.month - 1],
                                    underline: const SizedBox(),
                                    icon: const SizedBox(),
                                    onChanged: (value) {
                                      setState(() {
                                        calendarMonth = DateTime(
                                            calendarMonth.year, months.indexOf(value!) + 1);
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DropdownButton<int>(
                                    items: _yearList
                                        .map((e) =>
                                            DropdownMenuItem(value: e, child: Text(e.toString())))
                                        .toList(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
                                    dropdownColor: Colors.blueAccent,
                                    value: calendarMonth.year,
                                    underline: const SizedBox(),
                                    icon: const SizedBox(),
                                    onChanged: (value) {
                                      setState(() {
                                        calendarMonth = DateTime(value!, calendarMonth.month);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              // TODO: Builder needed?
                              FormField(
                                validator: (value) {
                                  if (selectedFromDate == null) {
                                    return "Date Must be selected";
                                  }
                                  return null;
                                },
                                builder: (field) {
                                  return CustomCalendar(
                                      calendarMonth: calendarMonth,
                                      selectedFromDate: selectedFromDate,
                                      selectedToDate: selectedToDate,
                                      dateUpdateFunction: (DateTime selectedDay) {
                                        setState(() {
                                          if (selectedFromDate == null) {
                                            selectedFromDate = selectedDay;
                                          } else if (selectedDay.isBefore(selectedFromDate!)) {
                                            selectedFromDate = selectedDay;
                                            selectedToDate = null;
                                          } else if (selectedToDate == null) {
                                            selectedToDate = selectedDay;
                                          } else {
                                            selectedFromDate = selectedDay;
                                            selectedToDate = null;
                                          }
                                        });
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const CurvedBox(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      FormField(
                        validator: (value) {
                          if (!LeaveType.values.contains(leaveType)) {
                            return "Must be a valid type";
                          }
                          return null;
                        },
                        builder: (field) => LeaveTypeWidget(
                            selectedType: leaveType!,
                            leaveTypeUpdateFunction: (String? selectedType) {
                              setState(() {
                                leaveType = selectedType;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      FormField<String>(
                          validator: (value) {
                            if (leaveReason == null || leaveReason!.isEmpty) {
                              return "Reason must be filled";
                            }
                            return null;
                          },
                          builder: (field) => LeaveReasonWidget(
                                reason: leaveReason,
                                updateFunction: (value) {
                                  leaveReason = value;
                                },
                              )),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: widget.currentLeaveApplication != null
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            if (widget.currentLeaveApplication != null)
                              Expanded(
                                child: CustomButton(
                                    onTap: () {
                                      context
                                          .read<DeleteLeaveCubit>()
                                          .deleteLeave(widget.currentLeaveApplication!);
                                    },
                                    text: "Delete"),
                              ),
                            if (widget.currentLeaveApplication != null)
                              const SizedBox(
                                width: 16,
                              ),
                            Expanded(
                              child: CustomButton(
                                text: widget.currentLeaveApplication == null
                                    ? "Apply for Leave"
                                    : "Update",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    LeaveApplication leaveApplication = LeaveApplication(
                                        id: widget.currentLeaveApplication?.id ??
                                            DateTime.now().toString(),
                                        fromDate: selectedFromDate!,
                                        toDate: selectedToDate,
                                        leaveType: leaveType!,
                                        reason: leaveReason!);
                                    if (widget.currentLeaveApplication == null) {
                                      context.read<ApplyLeaveCubit>().applyLeave(leaveApplication);
                                    } else {
                                      context
                                          .read<UpdateLeaveCubit>()
                                          .updateLeave(leaveApplication);
                                      //TODO: Call bloc
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
