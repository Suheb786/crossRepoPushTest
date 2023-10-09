// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mobile_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingVerifyMobileOtpRequestEntity
    _$OnboardingVerifyMobileOtpRequestEntityFromJson(
            Map<String, dynamic> json) =>
        OnboardingVerifyMobileOtpRequestEntity(
          OTPCode: json['OTPCode'] as String?,
          GetToken: json['GetToken'] as bool?,
          BaseClass: json['BaseClass'] as Map<String, dynamic>?,
        );

Map<String, dynamic> _$OnboardingVerifyMobileOtpRequestEntityToJson(
        OnboardingVerifyMobileOtpRequestEntity instance) =>
    <String, dynamic>{
      'OTPCode': instance.OTPCode,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
