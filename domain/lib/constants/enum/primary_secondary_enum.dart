class PrimarySecondaryEnum {
  final String _value;

  const PrimarySecondaryEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const PrimarySecondaryEnum PRIMARY = PrimarySecondaryEnum._("P");
  static const PrimarySecondaryEnum SECONDARY = PrimarySecondaryEnum._("S");
  static const PrimarySecondaryEnum NONE = PrimarySecondaryEnum._("none");
}

extension PrimarySecondaryEnumExt on String {
  PrimarySecondaryEnum fromPrimarySecondaryCardValue() {
    switch (this) {
      case "P":
        return PrimarySecondaryEnum.PRIMARY;
      case "S":
        return PrimarySecondaryEnum.SECONDARY;
      default:
        return PrimarySecondaryEnum.NONE;
    }
  }
}
