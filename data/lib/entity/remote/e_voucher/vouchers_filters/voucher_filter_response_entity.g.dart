// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_filter_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherFilterResponseEntity _$VoucherFilterResponseEntityFromJson(Map<String, dynamic> json) =>
    VoucherFilterResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherFilterResponseEntityToJson(VoucherFilterResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
