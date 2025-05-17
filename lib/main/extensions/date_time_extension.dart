import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String monthName() {
    return DateFormat.MMM().format(this);
  }

  String weekdayName() {
    return DateFormat.E().format(this);
  }
}
