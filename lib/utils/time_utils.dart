import 'package:intl/intl.dart';

class TimeUtils {
  TimeUtils._();

  /// Returns the difference (in full days) between the provided date and today.
  static int calculateDifference(DateTime? date) {
    DateTime now = DateTime.now();
    return DateTime(date!.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  static String getDifferenceText(String createdAt) {
    int difference = calculateDifference(DateTime.tryParse(createdAt));
    switch (difference) {
      case 0:
        return "Today";
      case -1:
        return "Yesterday";
      default:
        return getFormattedDate(createdAt);
    }
  }

  static String getFormattedDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('d MMMM y');
    return formatter.format(dateTime);
  }

  static String getFormattedDateTime(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('d MMMM y, hh:mm a ');
    return formatter.format(dateTime);
  }

  static String getFormattedDateForDateWidget(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat("E, d MMMM y");
    return formatter.format(dateTime);
  }
}
