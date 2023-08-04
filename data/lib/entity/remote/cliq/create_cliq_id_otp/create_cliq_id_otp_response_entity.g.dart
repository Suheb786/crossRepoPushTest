// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cliq_id_otp_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCliqIdOtpResponseEntity _$CreateCliqIdOtpResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CreateCliqIdOtpResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateCliqIdOtpResponseEntityToJson(
        CreateCliqIdOtpResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
