// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseEntity _$RegisterResponseEntityFromJson(
    Map<String, dynamic> json) {
  return RegisterResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegisterResponseEntityToJson(
        RegisterResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
