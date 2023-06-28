// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherHistoryRequest _$VoucherHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherHistoryRequest(
      PageNo: json['PageNo'] as String?,
      rangeOfMonths: json['RangeOfMonths'] as int?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherHistoryRequestToJson(
        VoucherHistoryRequest instance) =>
    <String, dynamic>{
      'PageNo': instance.PageNo,
      'RangeOfMonths': instance.rangeOfMonths,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
