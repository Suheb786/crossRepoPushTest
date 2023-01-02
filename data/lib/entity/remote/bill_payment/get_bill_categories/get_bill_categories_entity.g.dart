// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bill_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillCategoriesEntity _$GetBillCategoriesEntityFromJson(
    Map<String, dynamic> json) {
  return GetBillCategoriesEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetBillCategoriesEntityToJson(
        GetBillCategoriesEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
