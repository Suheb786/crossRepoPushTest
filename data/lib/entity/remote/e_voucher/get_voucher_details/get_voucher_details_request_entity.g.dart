// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_voucher_details_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVoucherDetailsRequestEntity _$GetVoucherDetailsRequestEntityFromJson(Map<String, dynamic> json) =>
    GetVoucherDetailsRequestEntity(
      OrderIdentifier: json['OrderIdentifier'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetVoucherDetailsRequestEntityToJson(GetVoucherDetailsRequestEntity instance) =>
    <String, dynamic>{
      'OrderIdentifier': instance.OrderIdentifier,
      'baseClass': instance.baseData,
    };
