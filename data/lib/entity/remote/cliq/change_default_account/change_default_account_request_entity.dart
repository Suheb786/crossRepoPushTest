// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'change_default_account_request_entity.g.dart';

@JsonSerializable()
class ChangeDefaultAccountRequestEntity {
  @JsonKey(name: "linkType")
  final String linkType;
  @JsonKey(name: "otpCode")
  final String otpCode;
  @JsonKey(name: "identifier")
  final String identifier;
  @JsonKey(name: "aliasId")
  final String aliasId;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseClass;

  ChangeDefaultAccountRequestEntity(
      {required this.linkType,
      required this.otpCode,
      required this.identifier,
      required this.aliasId,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() =>
      _$ChangeDefaultAccountRequestEntityToJson(this);

  factory ChangeDefaultAccountRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeDefaultAccountRequestEntityFromJson(json);
}
