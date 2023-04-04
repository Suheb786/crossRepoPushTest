class PaymentTypeEnum {
  final String _value;

  const PaymentTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const PaymentTypeEnum SEND_MONEY = PaymentTypeEnum._("Send Money");
  static const PaymentTypeEnum RTP_REQUEST = PaymentTypeEnum._("RTP Request");

  static const PaymentTypeEnum Payment_Type_NONE = PaymentTypeEnum._("None");
}

extension PaymentTypeEnumExt on String {
  PaymentTypeEnum fromPaymentType() {
    switch (this) {
      case "Send Money":
        return PaymentTypeEnum.SEND_MONEY;
      case "RTP Request":
        return PaymentTypeEnum.RTP_REQUEST;

      default:
        return PaymentTypeEnum.Payment_Type_NONE;
    }
  }
}
