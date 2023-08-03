// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_categories_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherCategoriesResponseEntity _$VoucherCategoriesResponseEntityFromJson(Map<String, dynamic> json) =>
    VoucherCategoriesResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherCategoriesResponseEntityToJson(VoucherCategoriesResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
