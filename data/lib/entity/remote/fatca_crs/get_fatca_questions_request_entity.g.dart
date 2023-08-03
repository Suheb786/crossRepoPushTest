// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fatca_questions_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFatcaQuestionsRequestEntity _$GetFatcaQuestionsRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetFatcaQuestionsRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
    );

Map<String, dynamic> _$GetFatcaQuestionsRequestEntityToJson(
        GetFatcaQuestionsRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
