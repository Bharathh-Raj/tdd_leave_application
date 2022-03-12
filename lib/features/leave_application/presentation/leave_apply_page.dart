import 'package:flutter/material.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';
import 'package:leave_application/features/leave_application/domain/my_calendar.dart';
import 'package:leave_application/features/leave_application/presentation/widgets/bg_paint.dart';

class LeaveApplyPage extends StatefulWidget {
  const LeaveApplyPage({Key? key}) : super(key: key);

  @override
  State<LeaveApplyPage> createState() => _LeaveApplyPageState();
}

class _LeaveApplyPageState extends State<LeaveApplyPage> {
  final DateTime calendarMonth = DateTime(2022, 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData.dark(),
        child: Builder(builder: (context) {
          return Column(
            children: [
              CustomPaint(
                  painter: BGPainter(),
                  child: SafeArea(
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
                                  .copyWith(fontWeight: FontWeight.w800),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                        CustomCalendar(calendarMonth: calendarMonth),
                      ],
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final DateTime calendarMonth;
  const CustomCalendar({Key? key, required this.calendarMonth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 36,
      dataRowHeight: 56,
      dividerThickness: 0,
      columns: const [
        DataColumn(label: Text("Mon")),
        DataColumn(label: Text("Tue")),
        DataColumn(label: Text("Wed")),
        DataColumn(label: Text("Thu")),
        DataColumn(label: Text("Fri")),
        DataColumn(label: Text("Sat")),
        DataColumn(label: Text("Sun")),
      ],
      rows: getWeekRowList(),
    );
  }

  List<DataRow> getWeekRowList() {
    List<DataRow> weekRowList = [];
    final int weekCount =
        MyCalendar.getWeekCount(month: calendarMonth.month, year: calendarMonth.year);

    for (int i = 1; i <= weekCount; i++) {
      final DateTimeRange range = MyCalendar.getWeekRowRange(
          rowNum: i, month: calendarMonth.month, year: calendarMonth.year);

      List<DataCell> weekRow = [];
      for (DateTime currentDay = range.start;
          currentDay.beforeOrEqual(range.end);
          currentDay = currentDay.addDay()) {
        weekRow.add(DataCell(Text(
          currentDay.day.toString(),
          style: TextStyle(
              color: currentDay.month != calendarMonth.month ? Colors.white38 : Colors.white),
        )));
      }

      weekRowList.add(DataRow(cells: weekRow));
    }
    return weekRowList;
  }
}
