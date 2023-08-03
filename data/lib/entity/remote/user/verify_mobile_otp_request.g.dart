// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mobile_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMobileOtpRequest _$VerifyMobileOtpRequestFromJson(Map<String, dynamic> json) => VerifyMobileOtpRequest(
      otpCode: json['otpCode'] as String? ?? "",
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VerifyMobileOtpRequestToJson(VerifyMobileOtpRequest instance) => <String, dynamic>{
      'otpCode': instance.otpCode,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
