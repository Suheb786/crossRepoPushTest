// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_cliq_id_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspendCliqIdOtpResponseEntity _$SuspendCliqIdOtpResponseEntityFromJson(
    Map<String, dynamic> json) {
  return SuspendCliqIdOtpResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SuspendCliqIdOtpResponseEntityToJson(
        SuspendCliqIdOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
