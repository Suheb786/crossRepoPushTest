// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityResponseEntity _$ActivityResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ActivityResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityResponseEntityToJson(
        ActivityResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
