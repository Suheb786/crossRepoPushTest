// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_activate_cliq_id_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReActivateCliqIdOtpResponseEntity _$ReActivateCliqIdOtpResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ReActivateCliqIdOtpResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReActivateCliqIdOtpResponseEntityToJson(
        ReActivateCliqIdOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
