import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "verify_mobile_otp_request.g.dart";

@JsonSerializable()
class VerifyMobileOtpRequest {
  @JsonKey(name: "otpCode")
  final String? otpCode;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  VerifyMobileOtpRequest(
      {this.otpCode: "", this.getToken: false, required this.baseData});

  factory VerifyMobileOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyMobileOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyMobileOtpRequestToJson(this);
}
