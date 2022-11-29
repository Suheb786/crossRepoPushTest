// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_forget_password_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyForgetPasswordOtpResponseEntity _$VerifyForgetPasswordOtpResponseEntityFromJson(
    Map<String, dynamic> json) {
  return VerifyForgetPasswordOtpResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VerifyForgetPasswordOtpResponseEntityToJson(
        VerifyForgetPasswordOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
