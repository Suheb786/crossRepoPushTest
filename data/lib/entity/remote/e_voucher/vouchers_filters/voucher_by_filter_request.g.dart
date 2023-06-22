// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_by_filter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherByFilterRequest _$VoucherByFilterRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherByFilterRequest(
      MinValue: json['MINVALUE'] as String?,
      Category: json['CATEGORY'] as String?,
      MaxValue: json['MAXVALUE'] as String?,
      Region: json['REGION'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherByFilterRequestToJson(
        VoucherByFilterRequest instance) =>
    <String, dynamic>{
      'CATEGORY': instance.Category,
      'REGION': instance.Region,
      'MAXVALUE': instance.MaxValue,
      'MINVALUE': instance.MinValue,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
