// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_min_max_value_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionMinMaxValueRequest _$VoucherRegionMinMaxValueRequestFromJson(Map<String, dynamic> json) =>
    VoucherRegionMinMaxValueRequest(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherRegionMinMaxValueRequestToJson(VoucherRegionMinMaxValueRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
