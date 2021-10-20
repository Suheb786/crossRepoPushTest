class TaxPayerEnum {
  final String _value;

  const TaxPayerEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const TaxPayerEnum SOCIAL_SECURITY = TaxPayerEnum._("Social Security");
  static const TaxPayerEnum EMPLOYER = TaxPayerEnum._("Employer");

  static const TaxPayerEnum NONE = TaxPayerEnum._("None");
}

extension TaxPayerEnumExt on String {
  TaxPayerEnum fromValue() {
    switch (this) {
      case "Social Security":
        return TaxPayerEnum.SOCIAL_SECURITY;
      case "Employer":
        return TaxPayerEnum.EMPLOYER;
      default:
        return TaxPayerEnum.NONE;
    }
  }
}
