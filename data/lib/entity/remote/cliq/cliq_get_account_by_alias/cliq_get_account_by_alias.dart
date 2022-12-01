// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cliq_get_account_by_alias.g.dart';

@JsonSerializable()
class GetCliqAccountByAliasEntity {
  @JsonKey(name: "alias")
  final String? alias;
  @JsonKey(name: "mobileNo")
  final String? mobileNo;
  @JsonKey(name: "iban")
  final String? iban;
  @JsonKey(name: "accountNo")
  final String? accountNo;
  @JsonKey(name: "swiftCode")
  final String? swiftCode;
  @JsonKey(name: "bankCountry")
  final String? bankCountry;
  @JsonKey(name: "transferType")
  final String? transferType;

  @JsonKey(name: "cliqType")
  final String? cliqType;

  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseClass;

  GetCliqAccountByAliasEntity({
    required this.alias,
    required this.mobileNo,
    required this.iban,
    required this.accountNo,
    required this.swiftCode,
    required this.bankCountry,
    required this.transferType,
    required this.cliqType,
    required this.getToken,
    required this.baseClass,
  });

  factory GetCliqAccountByAliasEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCliqAccountByAliasEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCliqAccountByAliasEntityToJson(this);
}
