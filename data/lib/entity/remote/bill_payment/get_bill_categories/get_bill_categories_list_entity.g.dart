// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bill_categories_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillCategoriesListEntity _$GetBillCategoriesListEntityFromJson(
    Map<String, dynamic> json) {
  return GetBillCategoriesListEntity(
    categoryName: json['categoryName'] as String?,
    iconCode: json['iconCode'] as String?,
    categoryNameAr: json['categoryNameAr'] as String?,
  );
}

Map<String, dynamic> _$GetBillCategoriesListEntityToJson(
        GetBillCategoriesListEntity instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'iconCode': instance.iconCode,
      'categoryNameAr': instance.categoryNameAr,
    };
