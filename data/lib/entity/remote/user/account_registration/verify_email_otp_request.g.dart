// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailOTPRequest _$VerifyEmailOTPRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOTPRequest(
      email: json['Email'] as String?,
      otpCode: json['OtpCode'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VerifyEmailOTPRequestToJson(
        VerifyEmailOTPRequest instance) =>
    <String, dynamic>{
      'Email': instance.email,
      'OtpCode': instance.otpCode,
      'baseClass': instance.baseData,
    };
