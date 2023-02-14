class TransactionStatusBillsEnum {
  final String _value;

  const TransactionStatusBillsEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const TransactionStatusBillsEnum SUCCESS = TransactionStatusBillsEnum._("Success");
  static const TransactionStatusBillsEnum FAIL = TransactionStatusBillsEnum._("Fail");
  static const TransactionStatusBillsEnum PENDING = TransactionStatusBillsEnum._("Pending");
}

extension TransactionStatusBillsEnumExt on String {
  TransactionStatusBillsEnum fromTransactionStatusBillsValue() {
    switch (this) {
      case "Pending":
        return TransactionStatusBillsEnum.PENDING;
      case "Fail":
        return TransactionStatusBillsEnum.FAIL;
      default:
        return TransactionStatusBillsEnum.SUCCESS;
    }
  }
}
