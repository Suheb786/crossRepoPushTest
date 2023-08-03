// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_by_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionByCategoriesEntity _$VoucherRegionByCategoriesEntityFromJson(Map<String, dynamic> json) =>
    VoucherRegionByCategoriesEntity(
      isoCode3: json['isoCode3'] as String? ?? '',
      isoCode: json['isoCode'] as String? ?? '',
      countryName: json['countryName'] as String? ?? '',
      countryNameAR: json['countryNameAR'] as String? ?? '',
    );

Map<String, dynamic> _$VoucherRegionByCategoriesEntityToJson(VoucherRegionByCategoriesEntity instance) =>
    <String, dynamic>{
      'isoCode3': instance.isoCode3,
      'isoCode': instance.isoCode,
      'countryName': instance.countryName,
      'countryNameAR': instance.countryNameAR,
    };
