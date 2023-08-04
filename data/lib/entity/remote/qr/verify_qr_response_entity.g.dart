// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_qr_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyQRResponseEntity _$VerifyQRResponseEntityFromJson(
        Map<String, dynamic> json) =>
    VerifyQRResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyQRResponseEntityToJson(
        VerifyQRResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
