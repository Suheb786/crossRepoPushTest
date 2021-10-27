class CalendarEnum {
  final String _value;

  const CalendarEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CalendarEnum YEAR = CalendarEnum._("Year");
  static const CalendarEnum MONTH = CalendarEnum._("Month");

  static const CalendarEnum DAY = CalendarEnum._("Day");

  static const CalendarEnum NONE = CalendarEnum._("None");
}

extension CalendarEnumExt on String {
  CalendarEnum fromValue() {
    switch (this) {
      case "Year":
        return CalendarEnum.YEAR;
      case "Month":
        return CalendarEnum.MONTH;
      case "Day":
        return CalendarEnum.DAY;
      default:
        return CalendarEnum.NONE;
    }
  }
}
