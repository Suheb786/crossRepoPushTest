// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_biller_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateBillerOtpEntity _$ValidateBillerOtpEntityFromJson(Map<String, dynamic> json) {
  return ValidateBillerOtpEntity(
    mobileNumber: json['mobileNumber'] as String?,
    isOtpRequired: json['isOtpRequired'] as bool?,
    isOtpSend: json['isOtpSend'] as bool?,
  );
}

Map<String, dynamic> _$ValidateBillerOtpEntityToJson(ValidateBillerOtpEntity instance) => <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'isOtpRequired': instance.isOtpRequired,
      'isOtpSend': instance.isOtpSend,
    };
