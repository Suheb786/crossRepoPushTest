import 'package:json_annotation/json_annotation.dart';

part "send_email_otp_request.g.dart";

@JsonSerializable()
class SendEmailOTPRequest {
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SendEmailOTPRequest(
      {required this.email, required this.password, required this.getToken, required this.baseData});

  factory SendEmailOTPRequest.fromJson(Map<String, dynamic> json) => _$SendEmailOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailOTPRequestToJson(this);
}
