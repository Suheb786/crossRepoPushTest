class CheckSendMoneyMessageEnum {
  final String _value;

  const CheckSendMoneyMessageEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CheckSendMoneyMessageEnum IBAN_FROM_BANKSSMART =
      CheckSendMoneyMessageEnum._("IBAN is from Banksmart");
  static const CheckSendMoneyMessageEnum IBAN_FROM_CliQ = CheckSendMoneyMessageEnum._("IBAN is from CliQ");
  static const CheckSendMoneyMessageEnum Mobile_NUMBER_BANKSMART =
      CheckSendMoneyMessageEnum._("Mobile number is from Banksmart");
  static const CheckSendMoneyMessageEnum MOBILE_NO_CLIQ =
      CheckSendMoneyMessageEnum._("Mobile number is from CliQ");
  static const CheckSendMoneyMessageEnum ACCOUNT_FROM_BANKSMART =
      CheckSendMoneyMessageEnum._("Account no is from Banksmart");
  static const CheckSendMoneyMessageEnum ALIAS_FROM_CliQ = CheckSendMoneyMessageEnum._("Alias is from CliQ");
  static const CheckSendMoneyMessageEnum NONE = CheckSendMoneyMessageEnum._("None");
}

extension CheckSendMoneyMessageEnumExt on String {
  CheckSendMoneyMessageEnum fromCheckSendMoneyMessageValue() {
    switch (this) {
      case "IBAN is from Banksmart":
        return CheckSendMoneyMessageEnum.IBAN_FROM_BANKSSMART;
      case "IBAN is from CliQ":
        return CheckSendMoneyMessageEnum.IBAN_FROM_CliQ;
      case "Mobile number is from Banksmart":
        return CheckSendMoneyMessageEnum.Mobile_NUMBER_BANKSMART;
      case "Mobile number is from CliQ":
        return CheckSendMoneyMessageEnum.MOBILE_NO_CLIQ;
      case "Account no is from Banksmart":
        return CheckSendMoneyMessageEnum.ACCOUNT_FROM_BANKSMART;
      case "Alias is from CliQ":
        return CheckSendMoneyMessageEnum.ALIAS_FROM_CliQ;
      default:
        return CheckSendMoneyMessageEnum.NONE;
    }
  }
}
