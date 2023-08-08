import 'package:json_annotation/json_annotation.dart';

part "verify_mobile_otp_request.g.dart";

@JsonSerializable()
class VerifyMobileOtpRequest {
  @JsonKey(name: "otpCode")
  final String? otpCode;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyMobileOtpRequest({this.otpCode = "", this.getToken = true, required this.baseData});

  factory VerifyMobileOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyMobileOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyMobileOtpRequestToJson(this);
}
