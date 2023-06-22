// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_by_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherByCategoryRequest _$VoucherByCategoryRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherByCategoryRequest(
      Category: json['Category'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherByCategoryRequestToJson(
        VoucherByCategoryRequest instance) =>
    <String, dynamic>{
      'Category': instance.Category,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
