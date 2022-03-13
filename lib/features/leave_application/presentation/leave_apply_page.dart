import 'package:flutter/material.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/bg_paint.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/curved_box.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/custom_calendar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_reason.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_type_widget.dart';

import '../domain/leave_type.dart';

class LeaveApplyPage extends StatefulWidget {
  const LeaveApplyPage({Key? key}) : super(key: key);

  @override
  State<LeaveApplyPage> createState() => _LeaveApplyPageState();
}

class _LeaveApplyPageState extends State<LeaveApplyPage> {
  final DateTime calendarMonth = DateTime(2021, 5);
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? leaveType = LeaveType.values.first;
  String? leaveReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_back_ios_rounded)),
                                Text(
                                  calendarMonth.toMonth() + " " + calendarMonth.year.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded)
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
                              updateFunction: (value) {
                                leaveReason = value;
                              },
                            )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LeaveApplication leaveApplication = LeaveApplication(
                                  id: selectedFromDate!,
                                  fromDate: selectedFromDate!,
                                  toDate: selectedToDate,
                                  leaveType: leaveType!,
                                  reason: leaveReason!);

                              //TODO: Call bloc
                            }
                          },
                          child: const Text("Apply for Leave")),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
