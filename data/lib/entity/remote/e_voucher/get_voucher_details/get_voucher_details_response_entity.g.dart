// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_voucher_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVoucherDetailResponseEntity _$GetVoucherDetailResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GetVoucherDetailResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetVoucherDetailResponseEntityToJson(
        GetVoucherDetailResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
