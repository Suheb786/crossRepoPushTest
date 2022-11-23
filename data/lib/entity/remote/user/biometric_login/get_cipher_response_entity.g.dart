// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cipher_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCipherResponseEntity _$GetCipherResponseEntityFromJson(Map<String, dynamic> json) {
  return GetCipherResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetCipherResponseEntityToJson(GetCipherResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
