// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_by_categories_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionByCategoriesRequest _$VoucherRegionByCategoriesRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherRegionByCategoriesRequest(
      category: json['Category'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherRegionByCategoriesRequestToJson(
        VoucherRegionByCategoriesRequest instance) =>
    <String, dynamic>{
      'Category': instance.category,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
