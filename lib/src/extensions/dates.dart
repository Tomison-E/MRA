import 'package:intl/intl.dart';

extension DateConverter on DateTime {
  String get toTime => DateFormat.Hm().format(this);

  String toGroupName([bool weekday = true]) {
    final now = DateTime.now();

    if (toDateString() == now.toDateString()) {
      return 'Today';
    }

    if (toDateString() ==
        now.subtract(const Duration(days: 1)).toDateString()) {
      return 'Yesterday';
    }

    String format = '';
    if (weekday) {
      format += '${DateFormat.WEEKDAY}, ';
    }

    format += '${DateFormat.DAY} '
        '${DateFormat.ABBR_MONTH}, ${DateFormat.YEAR}';

    return DateFormat(format).format(this);
  }

  String toDateString() {
    final format = DateFormat.yMd();
    return format.format(this).toLowerCase();
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
