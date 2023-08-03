// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCategoryEntity _$VoucherCategoryEntityFromJson(Map<String, dynamic> json) => VoucherCategoryEntity(
      id: json['id'] as num? ?? 0.0,
      categoryName: json['categoryName'] as String? ?? '',
      createdDate: json['createdDate'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      updatedDate: json['updatedDate'] as String? ?? '',
      updatedBy: json['updatedBy'] as String? ?? '',
      categoryNameAr: json['categoryNameAr'] as String? ?? '',
      categoryIcon: json['categoryIcon'] ?? '',
    );

Map<String, dynamic> _$VoucherCategoryEntityToJson(VoucherCategoryEntity instance) => <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'updatedBy': instance.updatedBy,
      'categoryNameAr': instance.categoryNameAr,
      'categoryIcon': instance.categoryIcon,
    };
