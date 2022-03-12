const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

extension DateTimeExtension on DateTime {
  String toDisplayDate() {
    final DateTime _localDateTime = toLocal();
    return _localDateTime.day.toString() +
        " " +
        months[_localDateTime.month - 1].substring(0, 3) +
        ", " +
        _localDateTime.year.toString();
  }

  DateTime addDay({int daysToAdd = 1}) {
    return add(Duration(days: daysToAdd));
  }

  bool beforeOrEqual(DateTime dateTime) {
    return isBefore(dateTime) || this == dateTime;
  }

  String toMonth() {
    return months[month - 1];
  }
}
