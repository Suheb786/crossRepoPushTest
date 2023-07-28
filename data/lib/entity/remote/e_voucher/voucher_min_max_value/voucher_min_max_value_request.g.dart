// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_min_max_value_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherMinMaxValueRequest _$VoucherMinMaxValueRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherMinMaxValueRequest(
      category: json['Category'] as String?,
      region: json['Region'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherMinMaxValueRequestToJson(
        VoucherMinMaxValueRequest instance) =>
    <String, dynamic>{
      'Category': instance.category,
      'Region': instance.region,
      'baseClass': instance.baseData,
    };
