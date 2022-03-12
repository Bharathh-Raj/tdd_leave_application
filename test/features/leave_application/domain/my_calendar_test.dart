import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/features/leave_application/domain/my_calendar.dart';

void main() {
  group("Get Calendar Start Day", () {
    //   test("March 2022 start day is 28-02-2022", () {
    //     DateTime startDay = MyCalendar.getCalendarStartDay(month: 3, year: 2022);
    //     expect(startDay, DateTime(2022, 2, 28));
    //   });
    //   test("January 2022 start day is 27-12-2021", () {
    //     DateTime startDay = MyCalendar.getCalendarStartDay(month: 1, year: 2022);
    //     expect(startDay, DateTime(2021, 12, 27));
    //   });
    // });
    //
    // group("Get Calendar end Day", () {
    //   test("March 2022 end day is 03-04-2022", () {
    //     DateTime endDay = MyCalendar.getCalendarEndDay(month: 3, year: 2022);
    //     expect(endDay, DateTime(2022, 4, 3));
    //   });
    //
    //   test("February 2022 end day is 6-3-2022", () {
    //     DateTime endDay = MyCalendar.getCalendarEndDay(month: 2, year: 2022);
    //     expect(endDay, DateTime(2022, 3, 6));
    //   });
    // });

    group("Get Week Row Range", () {
      test("March 2022 Row-1 28-02-2022 to 06-03-2022", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 1, month: 3, year: 2022);
        expect(range, DateTimeRange(start: DateTime(2022, 2, 28), end: DateTime(2022, 3, 6)));
      });
      test("March 2022 Row-5 28-03-2022 to 03-04-2022", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 5, month: 3, year: 2022);
        expect(range, DateTimeRange(start: DateTime(2022, 3, 28), end: DateTime(2022, 4, 3)));
      });
      test("March 2022 Row-3 14-03-2022 to 20-03-2022", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 3, month: 3, year: 2022);
        expect(range, DateTimeRange(start: DateTime(2022, 3, 14), end: DateTime(2022, 3, 20)));
      });

      test("February 2022 Row-5 28-02-2022 to 06-03-2022", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 5, month: 2, year: 2022);
        expect(range, DateTimeRange(start: DateTime(2022, 2, 28), end: DateTime(2022, 3, 06)));
      });

      test("January 2020 Row-1 30-12-2019 to 5-1-2020", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 1, month: 1, year: 2020);
        expect(range, DateTimeRange(start: DateTime(2019, 12, 30), end: DateTime(2020, 1, 5)));
      });

      test("December 2024 Row-6 30-12-2024 to 5-1-2025", () {
        DateTimeRange range = MyCalendar.getWeekRowRange(rowNum: 6, month: 12, year: 2024);
        expect(range, DateTimeRange(start: DateTime(2024, 12, 30), end: DateTime(2025, 1, 5)));
      });
    });

    group("Get Week Count", () {
      group("31 days month", () {
        test("August 2022 starts in monday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 8, year: 2022);
          expect(result, 5);
        });
        test("March 2022 starts in tuesday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 3, year: 2022);
          expect(result, 5);
        });
        test("January 2022 starts in saturday have 6 weeks", () {
          int result = MyCalendar.getWeekCount(month: 1, year: 2022);
          expect(result, 6);
        });
        test("May 2022 starts in sunday have 6 weeks", () {
          int result = MyCalendar.getWeekCount(month: 5, year: 2022);
          expect(result, 6);
        });
      });

      group("30 days month", () {
        test("June 2020 starts in monday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 6, year: 2020);
          expect(result, 5);
        });
        test("April 2022 starts in friday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 4, year: 2022);
          expect(result, 5);
        });
        test("June 2022 starts in sunday have 6 weeks", () {
          int result = MyCalendar.getWeekCount(month: 6, year: 2025);
          expect(result, 6);
        });
      });

      group("29 days month", () {
        test("February 2016 starts in monday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 2, year: 2016);
          expect(result, 5);
        });
        test("February 2032 starts in sunday have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 2, year: 2032);
          expect(result, 5);
        });
      });

      group("28 days month", () {
        test("February 2021 starts in monday days have 4 weeks", () {
          int result = MyCalendar.getWeekCount(month: 2, year: 2021);
          expect(result, 4);
        });
        test("February 2022 starts in tuesday days have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 2, year: 2022);
          expect(result, 5);
        });
        test("February 2015 starts in sunday days have 5 weeks", () {
          int result = MyCalendar.getWeekCount(month: 2, year: 2015);
          expect(result, 5);
        });
      });
    });
  });
}
