import 'package:flutter/material.dart';

class MyCalendar {
  // static DateTime getCalendarStartDay({required int month, required int year}) {
  //   DateTime firstDayInMonth = DateTime(year, month, 1);
  //   DateTime calendarStartDay =
  //       firstDayInMonth.subtract(Duration(days: firstDayInMonth.weekday - 1));
  //   return calendarStartDay;
  // }
  //
  // static DateTime getCalendarEndDay({required int month, required int year}) {
  //   DateTime lastDayInMonth = DateTime(year, month + 1, 0);
  //   DateTime calendarEndDay = lastDayInMonth.add(Duration(days: 7 - lastDayInMonth.weekday));
  //
  //   return calendarEndDay;
  // }

  static DateTimeRange getWeekRowRange(
      {required int rowNum, required int month, required int year}) {
    DateTime firstDayInMonth = DateTime(year, month, ((rowNum - 1) * 7) + 1);
    DateTime currentRowMonday =
        firstDayInMonth.subtract(Duration(days: firstDayInMonth.weekday - 1));
    DateTime currentRowSunday = currentRowMonday.add(const Duration(days: 6));
    return DateTimeRange(start: currentRowMonday, end: currentRowSunday);
  }

  static int getWeekCount({required int month, required int year}) {
    DateTime firstDayInMonth = DateTime(year, month, 1);
    DateTime lastDayInMonth = DateTime(year, month + 1, 0);
    const int numberOfDaysInAWeek = 7;

    int numberOfDaysInMonth = lastDayInMonth.difference(firstDayInMonth).inDays + 1;
    int startWeekDay = firstDayInMonth.weekday - 1; // -1 is coz weekday starts with 1
    double totalWeekCount = (numberOfDaysInMonth + startWeekDay) / numberOfDaysInAWeek;
    if (totalWeekCount % 1 == 0) {
      return totalWeekCount.toInt();
    }
    return (totalWeekCount ~/ 1) + 1;
  }
}
