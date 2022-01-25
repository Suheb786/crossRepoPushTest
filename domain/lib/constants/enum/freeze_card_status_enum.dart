class FreezeCardStatusEnum {
  final String _value;

  const FreezeCardStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const FreezeCardStatusEnum A = FreezeCardStatusEnum._("A");
  static const FreezeCardStatusEnum F = FreezeCardStatusEnum._("F");
  static const FreezeCardStatusEnum C = FreezeCardStatusEnum._("C");
  static const FreezeCardStatusEnum WM = FreezeCardStatusEnum._("WM");
  static const FreezeCardStatusEnum SR = FreezeCardStatusEnum._("SR");
  static const FreezeCardStatusEnum NONE = FreezeCardStatusEnum._("none");
  static const FreezeCardStatusEnum PRE = FreezeCardStatusEnum._("PRE");
}

extension FreezeCardStatusEnumExt on String {
  FreezeCardStatusEnum fromFreezeCardStatusValue() {
    switch (this) {
      case "A":
        return FreezeCardStatusEnum.A;
      case "WM":
        return FreezeCardStatusEnum.WM;
      case "SR":
        return FreezeCardStatusEnum.SR;
      case "F":
        return FreezeCardStatusEnum.F;
      case "C":
        return FreezeCardStatusEnum.C;
      case "none":
        return FreezeCardStatusEnum.NONE;
      case "PRE":
        return FreezeCardStatusEnum.PRE;
      default:
        return FreezeCardStatusEnum.A;
    }
  }
}
