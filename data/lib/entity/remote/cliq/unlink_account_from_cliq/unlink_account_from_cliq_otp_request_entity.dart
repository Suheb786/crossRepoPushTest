// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'unlink_account_from_cliq_otp_request_entity.g.dart';

@JsonSerializable()
class UnLinkAccountFromCliqOtpRequestEntity {
  @JsonKey(name: "AliasId")
  final String? aliasId;
  @JsonKey(name: "AccountId")
  final String? accountId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseClass;

  UnLinkAccountFromCliqOtpRequestEntity(
      {required this.aliasId, required this.accountId, required this.getToken, required this.baseClass});

  Map<String, dynamic> toJson() => _$UnLinkAccountFromCliqOtpRequestEntityToJson(this);

  factory UnLinkAccountFromCliqOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UnLinkAccountFromCliqOtpRequestEntityFromJson(json);
}
