// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatca_questions_response_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FatcaQuestionsResponseContentDataEntity
    _$FatcaQuestionsResponseContentDataEntityFromJson(
        Map<String, dynamic> json) {
  return FatcaQuestionsResponseContentDataEntity(
    labelEn: json['labelEn'] as String?,
    labelAr: json['labelAr'] as String?,
    isMandatory: json['isMandatory'] as bool?,
    orderNo: json['orderNo'] as int?,
    type: json['type'] as String?,
    answer: json['answer'] as String?,
    docId: json['docId'],
  );
}

Map<String, dynamic> _$FatcaQuestionsResponseContentDataEntityToJson(
        FatcaQuestionsResponseContentDataEntity instance) =>
    <String, dynamic>{
      'labelEn': instance.labelEn,
      'labelAr': instance.labelAr,
      'isMandatory': instance.isMandatory,
      'orderNo': instance.orderNo,
      'type': instance.type,
      'answer': instance.answer,
      'docId': instance.docId,
    };
