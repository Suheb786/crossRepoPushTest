// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCategoryEntity _$VoucherCategoryEntityFromJson(
        Map<String, dynamic> json) =>
    VoucherCategoryEntity(
      bankCategory: json['bankCategory'] as String? ?? '',
      bankCategoryAr: json['bankCategoryAr'] as String? ?? '',
      bankCategoryIcon: json['bankCategoryIcon'] as String? ?? '',
      muneroCategories: json['muneroCategories'] as String? ?? '',
    );

Map<String, dynamic> _$VoucherCategoryEntityToJson(
        VoucherCategoryEntity instance) =>
    <String, dynamic>{
      'bankCategory': instance.bankCategory,
      'bankCategoryAr': instance.bankCategoryAr,
      'bankCategoryIcon': instance.bankCategoryIcon,
      'muneroCategories': instance.muneroCategories,
    };
