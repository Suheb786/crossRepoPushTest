// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_cliq_id_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditCliqOtpResponseEntity _$EditCliqOtpResponseEntityFromJson(
    Map<String, dynamic> json) {
  return EditCliqOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EditCliqOtpResponseEntityToJson(
        EditCliqOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
