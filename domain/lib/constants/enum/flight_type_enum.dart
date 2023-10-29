class FlightTypeEnum {
  final String _value;

  const FlightTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const FlightTypeEnum RoundTrip = FlightTypeEnum._("RoundTrip");
  static const FlightTypeEnum OnWay = FlightTypeEnum._("OnWay");
  static const FlightTypeEnum NONE = FlightTypeEnum._("None");
}

extension FlightTypeEnumExt on String {
  FlightTypeEnum fromFlightTypeValue() {
    switch (this) {
      case "RoundTrip":
        return FlightTypeEnum.RoundTrip;
      case "OnWay":
        return FlightTypeEnum.OnWay;
      case "None":
        return FlightTypeEnum.NONE;
      default:
        return FlightTypeEnum.NONE;
    }
  }
}
