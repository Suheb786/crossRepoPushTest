// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatca_questions_response_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FatcaQuestionsResponseContentDataEntity _$FatcaQuestionsResponseContentDataEntityFromJson(
    Map<String, dynamic> json) {
  return FatcaQuestionsResponseContentDataEntity(
    labelEn: json['labelEn'] as String?,
    labelAr: json['labelAr'] as String?,
    isMandatory: json['isMandatory'] as bool?,
    orderNo: json['orderNo'] as int?,
    type: json['type'] as String?,
    infoText: json['infoText'] as String?,
    showOption: json['showOption'] as bool?,
    isInfo: json['isInfo'] as bool?,
    additionData: (json['datas'] as List<dynamic>?)
        ?.map((e) => AdditionalFatcaDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    infoTextAr: json['infoTextAr'] as String?,
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
      'infoText': instance.infoText,
      'infoTextAr': instance.infoTextAr,
      'showOption': instance.showOption,
      'isInfo': instance.isInfo,
      'datas': instance.additionData,
    };
