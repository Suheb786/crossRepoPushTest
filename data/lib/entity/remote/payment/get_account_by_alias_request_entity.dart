import 'package:json_annotation/json_annotation.dart';

part "get_account_by_alias_request_entity.g.dart";

@JsonSerializable()
class GetAccountByAliasRequestEntity {
  @JsonKey(name: "Value")
  final String? value;
  @JsonKey(name: "Currency")
  final String? currency;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetAccountByAliasRequestEntity(
      {required this.baseData, this.value, this.currency, this.getToken: true});

  factory GetAccountByAliasRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountByAliasRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountByAliasRequestEntityToJson(this);
}
