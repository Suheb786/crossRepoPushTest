import 'package:json_annotation/json_annotation.dart';
part 'onboarding_mobile_otp_request_entity.g.dart';

@JsonSerializable()
class OnboardingMobileOTPRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "MobileNumber")
  final String? MobileNumber;
  @JsonKey(name: "MobileCode")
  final String? MobileCode;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? BaseClass;

  factory OnboardingMobileOTPRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingMobileOTPRequestEntityFromJson(json);

  OnboardingMobileOTPRequestEntity({
    required this.GetToken,
    required this.MobileNumber,
    required this.MobileCode,
    required this.BaseClass,
  });
  Map<String, dynamic> toJson() => _$OnboardingMobileOTPRequestEntityToJson(this);
}
