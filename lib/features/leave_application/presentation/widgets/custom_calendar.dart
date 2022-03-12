import 'package:flutter/material.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';

import '../../domain/my_calendar.dart';
import 'date_highlighter_paint.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime calendarMonth;
  const CustomCalendar({Key? key, required this.calendarMonth}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final double cellHeight = 48;
  final double cellWidth = 56;
  final double selectionSide = 32;

  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      horizontalMargin: 0,
      checkboxHorizontalMargin: 0,
      dividerThickness: 0,
      dataRowHeight: cellHeight,
      columns: [
        getDayTitle("Mon"),
        getDayTitle("Tue"),
        getDayTitle("Wed"),
        getDayTitle("Thu"),
        getDayTitle("Fri"),
        getDayTitle("Sat"),
        getDayTitle("Sun"),
      ],
      rows: getWeekRowList(),
    );
  }

  DataColumn getDayTitle(String day) {
    return DataColumn(
        label: SizedBox(
            width: cellWidth,
            child: Text(day, textAlign: TextAlign.center, style: TextStyle(fontSize: 16))));
  }

  List<DataRow> getWeekRowList() {
    List<DataRow> weekRowList = [];
    final int weekCount =
        MyCalendar.getWeekCount(month: widget.calendarMonth.month, year: widget.calendarMonth.year);

    for (int i = 1; i <= weekCount; i++) {
      final DateTimeRange range = MyCalendar.getWeekRowRange(
          rowNum: i, month: widget.calendarMonth.month, year: widget.calendarMonth.year);

      List<DataCell> weekRow = [];
      for (DateTime currentDay = range.start;
          currentDay.beforeOrEqual(range.end);
          currentDay = currentDay.addDay()) {
        weekRow.add(DataCell(SizedBox(width: cellWidth, child: dateEntry(currentDay)), onTap: () {
          setState(() {
            if (fromDate == null) {
              fromDate = currentDay;
            } else if (currentDay.isBefore(fromDate!)) {
              fromDate = currentDay;
              toDate = null;
            } else if (toDate == null) {
              toDate = currentDay;
            } else {
              fromDate = currentDay;
              toDate = null;
            }
          });
        }));
      }

      weekRowList.add(DataRow(cells: weekRow));
    }
    return weekRowList;
  }

  Widget dateEntry(DateTime currentDay) {
    final bool isSelected = currentDay == fromDate || currentDay == toDate;
    final Widget child = Center(
      child: Text(
        currentDay.day.toString(),
        style: TextStyle(
            color: isSelected
                ? Colors.blue
                : currentDay.month != widget.calendarMonth.month
                    ? Colors.white38
                    : Colors.white),
      ),
    );
    if (isSelected) {
      return Center(
          child: SizedBox(
        height: selectionSide,
        // width: selectionSide,
        child: CustomPaint(
          painter: DateHighlighterPaint(
              isToDateNull: toDate == null, paintTowardsRight: currentDay == fromDate),
          child: child,
        ),
      ));
    } else if (fromDate != null &&
        toDate != null &&
        currentDay.isAfter(fromDate!) &&
        currentDay.isBefore(toDate!)) {
      return SizedBox(
        height: selectionSide,
        width: selectionSide,
        child: ColoredBox(
          color: Colors.white.withOpacity(0.25),
          child: child,
        ),
      );
    }
    return child;
  }
}
