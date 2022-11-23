// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_id_info_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveIdInfoResponseEntity _$SaveIdInfoResponseEntityFromJson(Map<String, dynamic> json) {
  return SaveIdInfoResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaveIdInfoResponseEntityToJson(SaveIdInfoResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
