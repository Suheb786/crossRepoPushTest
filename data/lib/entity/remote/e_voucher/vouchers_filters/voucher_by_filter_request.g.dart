// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_by_filter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherByFilterRequest _$VoucherByFilterRequestFromJson(Map<String, dynamic> json) => VoucherByFilterRequest(
      category: json['Category'] as String?,
      region: json['Region'] as String?,
      minValue: json['MinValue'] as num?,
      maxValue: json['MaxValue'] as num?,
      searchText: json['SearchText'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherByFilterRequestToJson(VoucherByFilterRequest instance) => <String, dynamic>{
      'Category': instance.category,
      'Region': instance.region,
      'MinValue': instance.minValue,
      'MaxValue': instance.maxValue,
      'SearchText': instance.searchText,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
