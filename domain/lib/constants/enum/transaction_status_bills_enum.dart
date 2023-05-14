class TransactionStatusBillsEnum {
  final int _value;

  const TransactionStatusBillsEnum._(this._value);

  static const TransactionStatusBillsEnum SUCCESS = TransactionStatusBillsEnum._(1);
  static const TransactionStatusBillsEnum FAIL = TransactionStatusBillsEnum._(2);
  static const TransactionStatusBillsEnum PENDING = TransactionStatusBillsEnum._(3);
}

extension TransactionStatusBillsEnumExt on int {
  TransactionStatusBillsEnum fromTransactionStatusBillsValue() {
    switch (this) {
      case 1:
        return TransactionStatusBillsEnum.SUCCESS;
      case 2:
        return TransactionStatusBillsEnum.FAIL;
      default:
        return TransactionStatusBillsEnum.PENDING;
    }
  }
}
