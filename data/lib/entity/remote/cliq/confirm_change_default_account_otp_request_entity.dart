import 'package:json_annotation/json_annotation.dart';

part 'confirm_change_default_account_otp_request_entity.g.dart';

@JsonSerializable()
class ConfirmChangeDefaultAccountOtpRequestEntity {
  @JsonKey(name: "Acc")
  final String acc;
  @JsonKey(name: "AliasId")
  final String aliasId;

  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  ConfirmChangeDefaultAccountOtpRequestEntity(
      {required this.aliasId, required this.acc, required this.getToken, required this.baseClass});

  Map<String, dynamic> toJson() => _$ConfirmChangeDefaultAccountOtpRequestEntityToJson(this);

  factory ConfirmChangeDefaultAccountOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ConfirmChangeDefaultAccountOtpRequestEntityFromJson(json);
}
