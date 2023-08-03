// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fatca_questions_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFatcaQuestionsResponseEntity _$GetFatcaQuestionsResponseEntityFromJson(Map<String, dynamic> json) =>
    GetFatcaQuestionsResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetFatcaQuestionsResponseEntityToJson(GetFatcaQuestionsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
