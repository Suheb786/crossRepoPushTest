// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_fatca_questions_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFatcaQuestionsResponseEntity _$SetFatcaQuestionsResponseEntityFromJson(
        Map<String, dynamic> json) =>
    SetFatcaQuestionsResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SetFatcaQuestionsResponseEntityToJson(
        SetFatcaQuestionsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
