// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRResponseEntity _$QRResponseEntityFromJson(Map<String, dynamic> json) {
  return QRResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QRResponseEntityToJson(QRResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
