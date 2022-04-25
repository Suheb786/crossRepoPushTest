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
  static const CreditCardCallStatusEnum CALL_NOT_RECEIVED =
      CreditCardCallStatusEnum._("");
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
      case "":
        return CreditCardCallStatusEnum.CALL_NOT_RECEIVED;
      default:
        return CreditCardCallStatusEnum.NONE;
    }
  }
}
