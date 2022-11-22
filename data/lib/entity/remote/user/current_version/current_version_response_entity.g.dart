// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_version_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentVersionResponseEntity _$CurrentVersionResponseEntityFromJson(Map<String, dynamic> json) {
  return CurrentVersionResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CurrentVersionResponseEntityToJson(CurrentVersionResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
