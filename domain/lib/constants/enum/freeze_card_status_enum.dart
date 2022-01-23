class FreezeCardStatusEnum {
  final String _value;

  const FreezeCardStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const FreezeCardStatusEnum A = FreezeCardStatusEnum._("A");
  static const FreezeCardStatusEnum WM = FreezeCardStatusEnum._("WM");
  static const FreezeCardStatusEnum SR = FreezeCardStatusEnum._("SR");
  static const FreezeCardStatusEnum NONE = FreezeCardStatusEnum._("none");
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
      case "none":
        return FreezeCardStatusEnum.NONE;
      default:
        return FreezeCardStatusEnum.A;
    }
  }
}
