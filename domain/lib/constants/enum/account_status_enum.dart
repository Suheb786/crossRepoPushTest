class AccountStatusEnum {
  final String _value;

  const AccountStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const AccountStatusEnum ACTIVE = AccountStatusEnum._("Active");
  static const AccountStatusEnum DORMANT = AccountStatusEnum._("Dormant");
  static const AccountStatusEnum NONE = AccountStatusEnum._("None");
}

extension AccountStatusEnumExt on String {
  AccountStatusEnum fromAccountStatusValue() {
    switch (this) {
      case "Active":
        return AccountStatusEnum.ACTIVE;
      case "Dormant":
        return AccountStatusEnum.DORMANT;
      default:
        return AccountStatusEnum.NONE;
    }
  }
}
