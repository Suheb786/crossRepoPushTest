// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherHistoryRequest _$VoucherHistoryRequestFromJson(Map<String, dynamic> json) => VoucherHistoryRequest(
      pageNo: json['PageNo'] as int?,
      searchPhrase: json['searchPhrase'] as String?,
      rangeOfMonths: json['RangeOfMonths'] as int?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
      totalRecord: json['TotalRecord'] as int?,
    );

Map<String, dynamic> _$VoucherHistoryRequestToJson(VoucherHistoryRequest instance) => <String, dynamic>{
      'PageNo': instance.pageNo,
      'searchPhrase': instance.searchPhrase,
      'RangeOfMonths': instance.rangeOfMonths,
      'TotalRecord': instance.totalRecord,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
