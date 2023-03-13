// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'unlink_account_from_cliq_request_entity.g.dart';

@JsonSerializable()
class UnLinkAccountFromCliqRequestEntity {
  @JsonKey(name: "AliasId")
  final String? aliasId;
  @JsonKey(name: "AccountId")
  final String? accountId;
  @JsonKey(name: "OtpCode")
  final String? otpCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseClass;

  UnLinkAccountFromCliqRequestEntity(
      {required this.aliasId,
      required this.accountId,
      required this.otpCode,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$UnLinkAccountFromCliqRequestEntityToJson(this);

  factory UnLinkAccountFromCliqRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UnLinkAccountFromCliqRequestEntityFromJson(json);
}
