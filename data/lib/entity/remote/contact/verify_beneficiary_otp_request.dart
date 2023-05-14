import 'package:json_annotation/json_annotation.dart';

part 'verify_beneficiary_otp_request.g.dart';

@JsonSerializable()
class VerifyBeneficiaryOtpRequest {
  @JsonKey(name: "Type")
  final String type;
  @JsonKey(name: "OTPCode")
  final String otp;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VerifyBeneficiaryOtpRequest({
    required this.type,
    required this.otp,
    this.getToken= true,
    required this.baseData,
  });

  factory VerifyBeneficiaryOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyBeneficiaryOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBeneficiaryOtpRequestToJson(this);
}
