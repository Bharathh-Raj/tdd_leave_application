const List<String> _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

extension DisplayDate on DateTime {
  String toDisplayDate() {
    final DateTime _localDateTime = toLocal();
    return _localDateTime.day.toString() +
        " " +
        _months[_localDateTime.month - 1] +
        ", " +
        _localDateTime.year.toString();
  }
}
