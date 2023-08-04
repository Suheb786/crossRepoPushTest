// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atms_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtmsResponseEntity _$AtmsResponseEntityFromJson(Map<String, dynamic> json) =>
    AtmsResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AtmsResponseEntityToJson(AtmsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
