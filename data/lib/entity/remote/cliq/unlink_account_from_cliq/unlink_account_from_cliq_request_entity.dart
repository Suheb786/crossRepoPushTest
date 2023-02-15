// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'unlink_account_from_cliq_request_entity.g.dart';

@JsonSerializable()
class UnLinkAccountFromCliqRequestEntity {
  @JsonKey(name: "aliasId")
  final String? aliasId;
  @JsonKey(name: "accountId")
  final String? accountId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseClass;

  UnLinkAccountFromCliqRequestEntity(
      {required this.aliasId,
      required this.accountId,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() =>
      _$UnLinkAccountFromCliqRequestEntityToJson(this);

  factory UnLinkAccountFromCliqRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$UnLinkAccountFromCliqRequestEntityFromJson(json);
}
