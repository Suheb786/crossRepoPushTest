class USRelevantW8TaxPayerEnum {
  final String _value;

  const USRelevantW8TaxPayerEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const USRelevantW8TaxPayerEnum US = USRelevantW8TaxPayerEnum._("U.S.");
  static const USRelevantW8TaxPayerEnum FOREIGN =
      USRelevantW8TaxPayerEnum._("Foreign");

  static const USRelevantW8TaxPayerEnum NONE =
      USRelevantW8TaxPayerEnum._("None");
}

extension USRelevantW8TaxPayerEnumExt on String {
  USRelevantW8TaxPayerEnum fromValue() {
    switch (this) {
      case "U.S.":
        return USRelevantW8TaxPayerEnum.US;
      case "Foreign":
        return USRelevantW8TaxPayerEnum.FOREIGN;
      default:
        return USRelevantW8TaxPayerEnum.NONE;
    }
  }
}
