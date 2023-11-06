import 'package:json_annotation/json_annotation.dart';
part 'verify_mobile_otp_request_entity.g.dart';

@JsonSerializable()
class OnboardingVerifyMobileOtpRequestEntity {
  @JsonKey(name: "MobileNumber")
  final String? MobileNumber;
  @JsonKey(name: "OTPCode")
  final String? OTPCode;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? BaseClass;

  factory OnboardingVerifyMobileOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingVerifyMobileOtpRequestEntityFromJson(json);

  OnboardingVerifyMobileOtpRequestEntity({
    required this.MobileNumber,
    required this.OTPCode,
    required this.GetToken,
    required this.BaseClass,
  });
  Map<String, dynamic> toJson() => _$OnboardingVerifyMobileOtpRequestEntityToJson(this);
}
