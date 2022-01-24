class AdditionalDataTypeEnum {
  final String _value;

  const AdditionalDataTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const AdditionalDataTypeEnum NONE = AdditionalDataTypeEnum._("-");
  static const AdditionalDataTypeEnum DROPDOWN = AdditionalDataTypeEnum._("D");
  static const AdditionalDataTypeEnum TEXT_FIELD =
      AdditionalDataTypeEnum._("T");
}
