import 'package:json_annotation/json_annotation.dart';

part 'confirm_change_default_account_request_entity.g.dart';

@JsonSerializable()
class ConfirmChangeDefaultAccountRequestEntity {
  @JsonKey(name: "Acc")
  final String acc;
  @JsonKey(name: "AliasId")
  final String aliasId;

  @JsonKey(name: "OtpCode")
  final String otpCode;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  ConfirmChangeDefaultAccountRequestEntity(
      {required this.aliasId,
      required this.acc,
      required this.otpCode,
      required this.getToken,
      required this.baseClass});

  Map<String, dynamic> toJson() => _$ConfirmChangeDefaultAccountRequestEntityToJson(this);

  factory ConfirmChangeDefaultAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ConfirmChangeDefaultAccountRequestEntityFromJson(json);
}
