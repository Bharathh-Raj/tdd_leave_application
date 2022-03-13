import 'package:flutter/material.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';

import '../../domain/my_calendar.dart';
import 'date_highlighter_paint.dart';

typedef DateUpdateFunction = void Function(DateTime selectedDate);

class CustomCalendar extends StatelessWidget {
  final DateTime calendarMonth;
  final DateTime? selectedFromDate;
  final DateTime? selectedToDate;
  final DateUpdateFunction dateUpdateFunction;

  const CustomCalendar(
      {Key? key,
      required this.calendarMonth,
      this.selectedFromDate,
      this.selectedToDate,
      required this.dateUpdateFunction})
      : super(key: key);

  final double cellHeight = 48;
  final double cellWidth = 60;
  final double selectionSide = 32;

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
            child: Text(day, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16))));
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
        weekRow.add(DataCell(SizedBox(width: cellWidth, child: dateEntry(currentDay)), onTap: () {
          dateUpdateFunction(currentDay);
        }));
      }

      weekRowList.add(DataRow(cells: weekRow));
    }
    return weekRowList;
  }

  Widget dateEntry(DateTime currentDay) {
    final bool isSelected = currentDay == selectedFromDate || currentDay == selectedToDate;
    final Widget child = Center(
      child: Text(
        currentDay.day.toString(),
        style: TextStyle(
            color: isSelected
                ? Colors.blue
                : currentDay.month != calendarMonth.month
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
              isToDateNull: selectedToDate == null,
              paintTowardsRight: currentDay == selectedFromDate),
          child: child,
        ),
      ));
    } else if (selectedFromDate != null &&
        selectedToDate != null &&
        currentDay.isAfter(selectedFromDate!) &&
        currentDay.isBefore(selectedToDate!)) {
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
