class PrimarySecondaryCardEnum {
  final String _value;

  const PrimarySecondaryCardEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const PrimarySecondaryCardEnum PRIMARY =
      PrimarySecondaryCardEnum._("Primary Card");
  static const PrimarySecondaryCardEnum SECONDARY =
      PrimarySecondaryCardEnum._("Secondary Card");
  static const PrimarySecondaryCardEnum NONE =
      PrimarySecondaryCardEnum._("None");
}

extension PrimarySecondaryCardEnumExt on String {
  PrimarySecondaryCardEnum fromPrimarySecondaryCard() {
    switch (this) {
      case "Primary Card":
        return PrimarySecondaryCardEnum.PRIMARY;
      case "Secondary Card":
        return PrimarySecondaryCardEnum.SECONDARY;
      case "None":
        return PrimarySecondaryCardEnum.NONE;
      default:
        return PrimarySecondaryCardEnum.NONE;
    }
  }
}
