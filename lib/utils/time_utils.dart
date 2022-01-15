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

  static int getMonth(String month) {
    switch (month) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        return 1;
    }
  }

  static Iterable<String> getTimeRange() {
    var base =
        DateTime.fromMillisecondsSinceEpoch(11 * Duration.millisecondsPerHour);
    var list =
        List.generate(48, (index) => base.add(Duration(minutes: 30) * index))
            .map((dt) => DateFormat.jm().format(dt));
    return list;
  }

  static String getFormattedDOB(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('dd/MM/y');
    return formatter.format(dateTime);
  }

  static String getFormattedMMMYYYY(String date) {
    final DateTime dateTime = DateFormat('MM/yyyy').parse(date).toLocal();
    return DateFormat('MMM yyyy').format(dateTime);
  }

  static String getFormattedDateForTransaction(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('d MMM');
    return formatter.format(dateTime);
  }

  static String getFormattedTimeForTransaction(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('HH:mm a');
    return formatter.format(dateTime);
  }

  static String getFormattedDateForCreditCard(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    final DateFormat formatter = DateFormat('d MMM y');
    return formatter.format(dateTime);
  }
}
