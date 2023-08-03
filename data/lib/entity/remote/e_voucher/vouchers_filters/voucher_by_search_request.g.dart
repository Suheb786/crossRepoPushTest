// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_by_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherBySearchRequest _$VoucherBySearchRequestFromJson(Map<String, dynamic> json) => VoucherBySearchRequest(
      SearchText: json['SearchText'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherBySearchRequestToJson(VoucherBySearchRequest instance) => <String, dynamic>{
      'SearchText': instance.SearchText,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
