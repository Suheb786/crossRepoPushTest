// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeEntity _$PurposeEntityFromJson(Map<String, dynamic> json) {
  return PurposeEntity(
    code: json['code'] as String?,
    labelEn: json['labelEN'] as String?,
    labelAr: json['labelAR'] as String?,
    purposeDetails: (json['purposeDetails'] as List<dynamic>?)
        ?.map((e) => PurposeDetailEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PurposeEntityToJson(PurposeEntity instance) => <String, dynamic>{
      'code': instance.code,
      'labelEN': instance.labelEn,
      'labelAR': instance.labelAr,
      'purposeDetails': instance.purposeDetails,
    };
