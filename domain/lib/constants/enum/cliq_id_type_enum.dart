class CliqIdTypeEnum {
  final String _value;

  const CliqIdTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CliqIdTypeEnum ALIAS = CliqIdTypeEnum._("Alias");
  static const CliqIdTypeEnum MOBILE_NO = CliqIdTypeEnum._("Mobile Number");
  static const CliqIdTypeEnum NONE = CliqIdTypeEnum._("None");
}

extension CliqIdTypeEnumExt on String {
  CliqIdTypeEnum fromCliqIdTypeValue() {
    switch (this) {
      case "Alias":
        return CliqIdTypeEnum.ALIAS;
      case "Mobile Number":
        return CliqIdTypeEnum.MOBILE_NO;
      case 'الاسم المستعار':
        return CliqIdTypeEnum.ALIAS;
      case 'رقم الموبايل':
        return CliqIdTypeEnum.MOBILE_NO;
      case "None":
        return CliqIdTypeEnum.NONE;
      default:
        return CliqIdTypeEnum.NONE;
    }
  }
}
