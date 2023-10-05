class FlightTypeEnum {
  final String _value;

  const FlightTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const FlightTypeEnum RoundTrip = FlightTypeEnum._("RoundTrip");
  static const FlightTypeEnum NONE = FlightTypeEnum._("None");
}

extension FlightTypeEnumExt on String {
  FlightTypeEnum fromFlightTypeValue() {
    switch (this) {
      case "RoundTrip":
        return FlightTypeEnum.RoundTrip;

      case "None":
        return FlightTypeEnum.NONE;
      default:
        return FlightTypeEnum.NONE;
    }
  }
}
