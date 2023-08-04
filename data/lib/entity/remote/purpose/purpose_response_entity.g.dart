// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeResponseEntity _$PurposeResponseEntityFromJson(
        Map<String, dynamic> json) =>
    PurposeResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurposeResponseEntityToJson(
        PurposeResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
