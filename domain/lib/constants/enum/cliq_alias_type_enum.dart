// ignore_for_file: public_member_api_docs, sort_constructors_first

class CliqAliasTypeEnum {
  final String _value;

  const CliqAliasTypeEnum._(this._value);

  @override
  String toString() => _value.toString();

  static const CliqAliasTypeEnum MOBL = CliqAliasTypeEnum._("MOBL");
  static const CliqAliasTypeEnum ALIAS = CliqAliasTypeEnum._("ALIAS");
}

extension CliqAliasTypeEnumExt on String {
  CliqAliasTypeEnum fromCliqAliasType() {
    switch (this) {
      case "MOBL":
        return CliqAliasTypeEnum.MOBL;

      default:
        return CliqAliasTypeEnum.ALIAS;
    }
  }
}

extension CliqAliasTypeStringExt on CliqAliasTypeEnum {
  String fromCliqAliasString() {
    switch (this) {
      case CliqAliasTypeEnum.ALIAS:
        return 'Alias';
      case CliqAliasTypeEnum.MOBL:
        return 'Mobile Number';

      default:
        return 'Alias';
    }
  }
}
