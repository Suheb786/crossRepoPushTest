// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_default_account_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeDefaultAccountOtpResponseEntity
    _$ChangeDefaultAccountOtpResponseEntityFromJson(Map<String, dynamic> json) {
  return ChangeDefaultAccountOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChangeDefaultAccountOtpResponseEntityToJson(
        ChangeDefaultAccountOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
