class CreditCardCallStatusEnum {
  final String _value;

  const CreditCardCallStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CreditCardCallStatusEnum APPROVED =
      CreditCardCallStatusEnum._("A");
  static const CreditCardCallStatusEnum DROP = CreditCardCallStatusEnum._("D");
  static const CreditCardCallStatusEnum REJECTED =
      CreditCardCallStatusEnum._("R");
  static const CreditCardCallStatusEnum NONE =
      CreditCardCallStatusEnum._("None");
}

extension CreditCardCallStatusEnumExt on String {
  CreditCardCallStatusEnum fromCreditCardCallStatusValue() {
    switch (this) {
      case "A":
        return CreditCardCallStatusEnum.APPROVED;
      case "D":
        return CreditCardCallStatusEnum.DROP;
      case "R":
        return CreditCardCallStatusEnum.REJECTED;
      case "None":
        return CreditCardCallStatusEnum.NONE;
      default:
        return CreditCardCallStatusEnum.NONE;
    }
  }
}
