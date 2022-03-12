import 'package:flutter/material.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/bg_paint.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/curved_box.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/custom_calendar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_reason.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/leave_type_widget.dart';

class LeaveApplyPage extends StatelessWidget {
  final DateTime calendarMonth = DateTime(2021, 5);

  LeaveApplyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                                  onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_rounded)),
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
                          CustomCalendar(
                            calendarMonth: calendarMonth,
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
                  const LeaveTypeWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  const LeaveReasonWidget(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(onPressed: () {}, child: const Text("Apply for Leave")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
