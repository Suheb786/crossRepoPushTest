// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeholder_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceholderResponseEntity _$PlaceholderResponseEntityFromJson(Map<String, dynamic> json) =>
    PlaceholderResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceholderResponseEntityToJson(PlaceholderResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
