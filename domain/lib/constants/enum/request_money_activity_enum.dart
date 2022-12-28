class RequestMoneyActivityStatusEnum {
  final String _value;

  const RequestMoneyActivityStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const RequestMoneyActivityStatusEnum CATEGORY_PENDING =
      RequestMoneyActivityStatusEnum._("Pending");
  static const RequestMoneyActivityStatusEnum CATEGORY_REJECTED =
      RequestMoneyActivityStatusEnum._("Rejected");
  static const RequestMoneyActivityStatusEnum CATEGORY_ACCEPTED =
      RequestMoneyActivityStatusEnum._("Accepted");
  static const RequestMoneyActivityStatusEnum CATEGORY_EXPIRED =
      RequestMoneyActivityStatusEnum._("Expired");
  static const RequestMoneyActivityStatusEnum CATEGORY_NONE =
      RequestMoneyActivityStatusEnum._("None");
  static const RequestMoneyActivityStatusEnum TRANSACTION_DIRECTORY_INCOMING =
      RequestMoneyActivityStatusEnum._("I");
  static const RequestMoneyActivityStatusEnum TRANSACTION_DIRECTORY_OUTGOING =
      RequestMoneyActivityStatusEnum._("O");
}

extension TransactionStatusEnumExt on String {
  RequestMoneyActivityStatusEnum fromRequestactivityStatus() {
    switch (this) {
      case "NACK":
        return RequestMoneyActivityStatusEnum.CATEGORY_PENDING;
      case "RJCT":
        return RequestMoneyActivityStatusEnum.CATEGORY_REJECTED;
      case "ACSP":
        return RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED;
      case "EXPRD":
        return RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED;
      case "I":
        return RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING;
      case "O":
        return RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING;
      default:
        return RequestMoneyActivityStatusEnum.CATEGORY_NONE;
    }
  }
}
