// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_job_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveJobDetailsResponseEntity _$SaveJobDetailsResponseEntityFromJson(
    Map<String, dynamic> json) {
  return SaveJobDetailsResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaveJobDetailsResponseEntityToJson(
    SaveJobDetailsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
