// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bill_categories_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillCategoriesDataEntity _$GetBillCategoriesDataEntityFromJson(Map<String, dynamic> json) =>
    GetBillCategoriesDataEntity(
      getBillCategoriesList: (json['categoriesList'] as List<dynamic>?)
          ?.map((e) => GetBillCategoriesListEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBillCategoriesDataEntityToJson(GetBillCategoriesDataEntity instance) =>
    <String, dynamic>{
      'categoriesList': instance.getBillCategoriesList,
    };
