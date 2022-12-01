// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'add_link_account_request_entity.g.dart';

@JsonSerializable()
class AddLinkAccountRequestEntity {
  @JsonKey(name: "aliasId")
  final String aliasId;
  @JsonKey(name: "linkType")
  final String linkType;
  @JsonKey(name: "accountNumber")
  final String accountNumber;
  @JsonKey(name: "isAlias")
  final bool isAlias;
  @JsonKey(name: "aliasValue")
  final String aliasValue;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
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
