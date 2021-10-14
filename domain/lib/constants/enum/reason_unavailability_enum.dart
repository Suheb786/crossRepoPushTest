class ReasonUnavailabilityEnum {
  final String _value;

  const ReasonUnavailabilityEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const ReasonUnavailabilityEnum REASON_A =
      ReasonUnavailabilityEnum._("Reason A");
  static const ReasonUnavailabilityEnum REASON_B =
      ReasonUnavailabilityEnum._("Reason B");

  static const ReasonUnavailabilityEnum REASON_C =
      ReasonUnavailabilityEnum._("Reason C");

  static const ReasonUnavailabilityEnum NONE =
      ReasonUnavailabilityEnum._("None");
}

extension ReasonUnavailabilityEnumExt on String {
  ReasonUnavailabilityEnum fromValue() {
    switch (this) {
      case "Reason A":
        return ReasonUnavailabilityEnum.REASON_A;
      case "Reason B":
        return ReasonUnavailabilityEnum.REASON_B;
      case "Reason C":
        return ReasonUnavailabilityEnum.REASON_C;
      default:
        return ReasonUnavailabilityEnum.NONE;
    }
  }
}
