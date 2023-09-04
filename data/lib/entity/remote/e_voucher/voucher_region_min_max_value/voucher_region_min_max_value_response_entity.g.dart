// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_region_min_max_value_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRegionMinMaxValueResponseEntity
    _$VoucherRegionMinMaxValueResponseEntityFromJson(
            Map<String, dynamic> json) =>
        VoucherRegionMinMaxValueResponseEntity(
          json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VoucherRegionMinMaxValueResponseEntityToJson(
        VoucherRegionMinMaxValueResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
