// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

class CliqAliasIdStatusEnum {
  final String _value;

  const CliqAliasIdStatusEnum._(this._value);

  @override
  String toString() => _value.toString();

  static const CliqAliasIdStatusEnum ACTIVE = CliqAliasIdStatusEnum._("A");
  static const CliqAliasIdStatusEnum SUSPAND = CliqAliasIdStatusEnum._("S");
  static const CliqAliasIdStatusEnum NONE = CliqAliasIdStatusEnum._("None");
}

extension CliqAliasIdStatusEnumExt on String {
  CliqAliasIdStatusEnum fromCliqAliasIdStatus() {
    switch (this) {
      case "A":
        return CliqAliasIdStatusEnum.ACTIVE;
      case "S":
        return CliqAliasIdStatusEnum.SUSPAND;

      default:
        return CliqAliasIdStatusEnum.SUSPAND;
    }
  }
}
