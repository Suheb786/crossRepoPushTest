class CustomerStatusEnum {
  final String _value;

  const CustomerStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CustomerStatusEnum HOLD = CustomerStatusEnum._("holdingPage");
  static const CustomerStatusEnum VIDEO_CALL =
      CustomerStatusEnum._("videoCall");
  static const CustomerStatusEnum SUCCESS =
      CustomerStatusEnum._("accountSuccess");
  static const CustomerStatusEnum ACCOUNT_PAGE =
      CustomerStatusEnum._("accountPage");
  static const CustomerStatusEnum DOC_UPLOAD =
      CustomerStatusEnum._("docupload");
  static const CustomerStatusEnum REMOVE_DEBIT_LOCK =
      CustomerStatusEnum._("removeDebitLock");
  static const CustomerStatusEnum CARD_ISSUANCE =
      CustomerStatusEnum._("cardIssuance");
  static const CustomerStatusEnum NONE = CustomerStatusEnum._("none");
}

extension CustomerStatusEnumExt on String {
  CustomerStatusEnum fromCustomerStatusValue() {
    switch (this) {
      case "holdingPage":
        return CustomerStatusEnum.HOLD;
      case "videoCall":
        return CustomerStatusEnum.VIDEO_CALL;
      case "accountSuccess":
        return CustomerStatusEnum.SUCCESS;
      case "accountPage":
        return CustomerStatusEnum.ACCOUNT_PAGE;
      case "docupload":
        return CustomerStatusEnum.DOC_UPLOAD;
      case "removeDebitLock":
        return CustomerStatusEnum.REMOVE_DEBIT_LOCK;
      case "cardIssuance":
        return CustomerStatusEnum.CARD_ISSUANCE;
      case "none":
        return CustomerStatusEnum.NONE;
      default:
        return CustomerStatusEnum.HOLD;
    }
  }
}
