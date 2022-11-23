class TransactionStatusEnum {
  final String _value;

  const TransactionStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const TransactionStatusEnum CATEGORY_PENDING = TransactionStatusEnum._("Pending");
  static const TransactionStatusEnum CATEGORY_REJECTED = TransactionStatusEnum._("Rejected");
  static const TransactionStatusEnum CATEGORY_ACCEPTED = TransactionStatusEnum._("Accepted");
  static const TransactionStatusEnum CATEGORY_NONE = TransactionStatusEnum._("None");
}

extension TransactionStatusEnumExt on String {
  TransactionStatusEnum fromTransactionStatusValue() {
    switch (this) {
      case "Pending":
        return TransactionStatusEnum.CATEGORY_PENDING;
      case "Rejected":
        return TransactionStatusEnum.CATEGORY_REJECTED;
      case "Accepted":
        return TransactionStatusEnum.CATEGORY_ACCEPTED;
      default:
        return TransactionStatusEnum.CATEGORY_NONE;
    }
  }
}
