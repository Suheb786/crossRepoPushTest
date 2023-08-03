// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_gender_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckGenderResponseEntity _$CheckGenderResponseEntityFromJson(Map<String, dynamic> json) =>
    CheckGenderResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckGenderResponseEntityToJson(CheckGenderResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
