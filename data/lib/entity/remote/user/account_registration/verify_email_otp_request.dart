import 'package:json_annotation/json_annotation.dart';

part "verify_email_otp_request.g.dart";

@JsonSerializable()
class VerifyEmailOTPRequest {
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "OtpCode")
  final String? otpCode;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyEmailOTPRequest({required this.email, required this.otpCode, required this.baseData});

  factory VerifyEmailOTPRequest.fromJson(Map<String, dynamic> json) => _$VerifyEmailOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailOTPRequestToJson(this);
}
