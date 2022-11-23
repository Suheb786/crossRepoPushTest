// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fatca_questions_response_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FatcaQuestionsResponseContentEntity _$FatcaQuestionsResponseContentEntityFromJson(Map<String, dynamic> json) {
  return FatcaQuestionsResponseContentEntity(
    fatcaQuestionResponseDataContent: (json['data'] as List<dynamic>?)
        ?.map((e) => FatcaQuestionsResponseContentDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FatcaQuestionsResponseContentEntityToJson(
        FatcaQuestionsResponseContentEntity instance) =>
    <String, dynamic>{
      'data': instance.fatcaQuestionResponseDataContent,
    };
