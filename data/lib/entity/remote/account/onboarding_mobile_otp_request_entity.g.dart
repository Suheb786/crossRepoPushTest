// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_mobile_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingMobileOTPRequestEntity _$OnboardingMobileOTPRequestEntityFromJson(
        Map<String, dynamic> json) =>
    OnboardingMobileOTPRequestEntity(
      GetToken: json['GetToken'] as bool?,
      MobileNumber: json['MobileNumber'] as String?,
      MobileCode: json['MobileCode'] as String?,
      BaseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OnboardingMobileOTPRequestEntityToJson(
        OnboardingMobileOTPRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.GetToken,
      'MobileNumber': instance.MobileNumber,
      'MobileCode': instance.MobileCode,
      'BaseClass': instance.BaseClass,
    };
