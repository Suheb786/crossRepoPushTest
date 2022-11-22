// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeDetailEntity _$PurposeDetailEntityFromJson(Map<String, dynamic> json) {
  return PurposeDetailEntity(
    strCode: json['strCode'] as String?,
    labelEn: json['labelEN'] as String?,
    labelAr: json['labelAR'] as String?,
    limit: json['limit'] as num?,
  );
}

Map<String, dynamic> _$PurposeDetailEntityToJson(PurposeDetailEntity instance) => <String, dynamic>{
      'strCode': instance.strCode,
      'labelEN': instance.labelEn,
      'labelAR': instance.labelAr,
      'limit': instance.limit,
    };
