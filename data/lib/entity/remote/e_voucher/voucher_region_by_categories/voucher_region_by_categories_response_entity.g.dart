// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_by_categories_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionByCategoriesResponseEntity _$VoucherRegionByCategoriesResponseEntityFromJson(
        Map<String, dynamic> json) =>
    VoucherRegionByCategoriesResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherRegionByCategoriesResponseEntityToJson(
        VoucherRegionByCategoriesResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
