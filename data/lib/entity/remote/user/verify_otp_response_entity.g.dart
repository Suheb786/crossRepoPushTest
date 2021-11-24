// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponseEntity _$VerifyOtpResponseEntityFromJson(
    Map<String, dynamic> json) {
  return VerifyOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VerifyOtpResponseEntityToJson(
        VerifyOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
