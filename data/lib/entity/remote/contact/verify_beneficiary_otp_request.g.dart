// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_beneficiary_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyBeneficiaryOtpRequest _$VerifyBeneficiaryOtpRequestFromJson(
    Map<String, dynamic> json) {
  return VerifyBeneficiaryOtpRequest(
    type: json['Type'] as String,
    otp: json['OTPCode'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$VerifyBeneficiaryOtpRequestToJson(
        VerifyBeneficiaryOtpRequest instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'OTPCode': instance.otp,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
