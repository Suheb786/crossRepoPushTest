// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'add_link_account_request_entity.g.dart';

@JsonSerializable()
class AddLinkAccountRequestEntity {
  @JsonKey(name: "AliasId")
  final String aliasId;
  @JsonKey(name: "LinkType")
  final String linkType;
  @JsonKey(name: "AccountNumber")
  final String accountNumber;
  @JsonKey(name: "isAlias")
  final bool isAlias;
  @JsonKey(name: "AliasValue")
  final String aliasValue;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  AddLinkAccountRequestEntity(
      {required this.aliasId,
      required this.linkType,
      required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$AddLinkAccountRequestEntityToJson(this);

  factory AddLinkAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AddLinkAccountRequestEntityFromJson(json);
}
