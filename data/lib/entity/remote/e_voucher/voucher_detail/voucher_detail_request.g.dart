// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDetailRequest _$VoucherDetailRequestFromJson(
        Map<String, dynamic> json) =>
    VoucherDetailRequest(
      OrderIdentifier: json['OrderIdentifier'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VoucherDetailRequestToJson(
        VoucherDetailRequest instance) =>
    <String, dynamic>{
      'OrderIdentifier': instance.OrderIdentifier,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
