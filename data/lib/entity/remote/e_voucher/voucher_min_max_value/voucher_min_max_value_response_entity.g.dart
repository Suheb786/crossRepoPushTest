// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_min_max_value_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherMinMaxValueResponseEntity _$VoucherMinMaxValueResponseEntityFromJson(Map<String, dynamic> json) =>
    VoucherMinMaxValueResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherMinMaxValueResponseEntityToJson(VoucherMinMaxValueResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
