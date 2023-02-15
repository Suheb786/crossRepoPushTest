// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'cliq_get_account_by_alias.g.dart';

@JsonSerializable()
class GetCliqAccountByAliasEntity {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "Currency")
  final String? Currency;
  @JsonKey(name: "CustID")
  final String? CustID;

  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  GetCliqAccountByAliasEntity({
    required this.type,
    required this.value,
    required this.Currency,
    required this.CustID,
    required this.GetToken,
    required this.BaseClass,
  });

  factory GetCliqAccountByAliasEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCliqAccountByAliasEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCliqAccountByAliasEntityToJson(this);
}
