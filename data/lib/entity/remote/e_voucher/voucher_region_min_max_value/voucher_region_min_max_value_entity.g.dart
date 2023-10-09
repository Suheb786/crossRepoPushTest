// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_min_max_value_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionMinMaxValueEntity _$VoucherRegionMinMaxValueEntityFromJson(
        Map<String, dynamic> json) =>
    VoucherRegionMinMaxValueEntity(
      minMaxRange: json['minMaxRange'] == null
          ? null
          : VoucherMinMaxValueEntity.fromJson(
              json['minMaxRange'] as Map<String, dynamic>),
      allowedRegions: (json['allowedRegions'] as List<dynamic>?)
              ?.map((e) => VoucherRegionByCategoriesEntity.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VoucherRegionMinMaxValueEntityToJson(
        VoucherRegionMinMaxValueEntity instance) =>
    <String, dynamic>{
      'minMaxRange': instance.minMaxRange,
      'allowedRegions': instance.allowedRegions,
    };
