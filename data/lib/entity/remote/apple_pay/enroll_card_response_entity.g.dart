// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enroll_card_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollCardResponseEntity _$EnrollCardResponseEntityFromJson(
        Map<String, dynamic> json) =>
    EnrollCardResponseEntity(
      responseEntity: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnrollCardResponseEntityToJson(
        EnrollCardResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
