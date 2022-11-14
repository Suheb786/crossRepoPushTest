// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepaid_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepaidCategoriesEntity _$PrepaidCategoriesEntityFromJson(
    Map<String, dynamic> json) {
  return PrepaidCategoriesEntity(
    catCode: json['catCode'] as String?,
    shortDescriptionAr: json['shortDescriptionAr'] as String?,
    shortDescriptionEn: json['shortDescriptionEn'] as String?,
    descriptionEn: json['descriptionEn'] as String?,
    descriptionAr: json['descriptionAr'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$PrepaidCategoriesEntityToJson(
        PrepaidCategoriesEntity instance) =>
    <String, dynamic>{
      'catCode': instance.catCode,
      'shortDescriptionAr': instance.shortDescriptionAr,
      'shortDescriptionEn': instance.shortDescriptionEn,
      'descriptionEn': instance.descriptionEn,
      'descriptionAr': instance.descriptionAr,
      'type': instance.type,
    };
