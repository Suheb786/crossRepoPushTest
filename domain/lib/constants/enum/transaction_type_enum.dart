class TransactionTypeEnum {
  final String _value;

  const TransactionTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const TransactionTypeEnum TransactionHistory = TransactionTypeEnum._("A");
  static const TransactionTypeEnum PendingAuthorization = TransactionTypeEnum._("P");
  static const TransactionTypeEnum NONE = TransactionTypeEnum._("None");
}

extension TransactionTypeEnumExt on String {
  TransactionTypeEnum fromTransactionStatusValue() {
    switch (this) {
      case "A":
        return TransactionTypeEnum.TransactionHistory;
      case "P":
        return TransactionTypeEnum.PendingAuthorization;
      default:
        return TransactionTypeEnum.NONE;
    }
  }
}
