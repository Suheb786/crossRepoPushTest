class USRelevantW9TaxPayerEnum {
  final String _value;

  const USRelevantW9TaxPayerEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const USRelevantW9TaxPayerEnum SOCIAL_SECURITY =
      USRelevantW9TaxPayerEnum._("Social Security");
  static const USRelevantW9TaxPayerEnum EMPLOYER =
      USRelevantW9TaxPayerEnum._("Employer");

  static const USRelevantW9TaxPayerEnum NONE =
      USRelevantW9TaxPayerEnum._("None");
}

extension USRelevantW9TaxPayerEnumExt on String {
  USRelevantW9TaxPayerEnum fromValue() {
    switch (this) {
      case "Social Security":
        return USRelevantW9TaxPayerEnum.SOCIAL_SECURITY;
      case "Employer":
        return USRelevantW9TaxPayerEnum.EMPLOYER;
      default:
        return USRelevantW9TaxPayerEnum.NONE;
    }
  }
}
