// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fatca_questions_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFatcaQuestionsRequestEntity _$GetFatcaQuestionsRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetFatcaQuestionsRequestEntity(
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
    getToken: json['GetToken'] as bool?,
  );
}

Map<String, dynamic> _$GetFatcaQuestionsRequestEntityToJson(
        GetFatcaQuestionsRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
