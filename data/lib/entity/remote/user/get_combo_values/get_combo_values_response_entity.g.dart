// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_combo_values_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetComboValuesResponseEntity _$GetComboValuesResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetComboValuesResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetComboValuesResponseEntityToJson(
    GetComboValuesResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
