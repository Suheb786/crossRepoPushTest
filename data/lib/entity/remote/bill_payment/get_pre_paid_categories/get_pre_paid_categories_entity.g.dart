// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pre_paid_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrePaidCategoriesEntity _$GetPrePaidCategoriesEntityFromJson(Map<String, dynamic> json) =>
    GetPrePaidCategoriesEntity(
      code: json['code'] as String?,
      description: json['description'] as String?,
    )..type = json['type'] as String?;

Map<String, dynamic> _$GetPrePaidCategoriesEntityToJson(GetPrePaidCategoriesEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'type': instance.type,
    };
