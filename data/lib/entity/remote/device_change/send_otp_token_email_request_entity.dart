import 'package:json_annotation/json_annotation.dart';

part "send_otp_token_email_request_entity.g.dart";

@JsonSerializable()
class SendOtpTokenEmailRequestEntity {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SendOtpTokenEmailRequestEntity(
      {required this.baseData, this.getToken= true, this.type= "ChangeDeviceEmail"});

  factory SendOtpTokenEmailRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOtpTokenEmailRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpTokenEmailRequestEntityToJson(this);
}
