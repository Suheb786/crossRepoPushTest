class FatcaEnum {
  final String _value;

  const FatcaEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const FatcaEnum w9 = FatcaEnum._("w9");
  static const FatcaEnum w8 = FatcaEnum._("w8");
  static const FatcaEnum CONFIRMATION_SCREEN =
      FatcaEnum._("confirmationScreeen");
  static const FatcaEnum NONE = FatcaEnum._("None");
}

extension FatcaEnumExt on String {
  FatcaEnum fromValue() {
    switch (this) {
      case "w9":
        return FatcaEnum.w9;
      case "w8":
        return FatcaEnum.w8;
      case "confirmationScreeen":
        return FatcaEnum.CONFIRMATION_SCREEN;
      case "None":
        return FatcaEnum.NONE;
      default:
        return FatcaEnum.CONFIRMATION_SCREEN;
    }
  }
}
