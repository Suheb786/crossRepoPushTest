// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pre_paid_categories_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrePaidCategoriesListEntity _$GetPrePaidCategoriesListEntityFromJson(
        Map<String, dynamic> json) =>
    GetPrePaidCategoriesListEntity(
      getPrePaidCategoriesEntity: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              GetPrePaidCategoriesEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPrePaidCategoriesListEntityToJson(
        GetPrePaidCategoriesListEntity instance) =>
    <String, dynamic>{
      'categories': instance.getPrePaidCategoriesEntity,
    };
