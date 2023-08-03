// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_min_max_value_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherMinMaxValueEntity _$VoucherMinMaxValueEntityFromJson(Map<String, dynamic> json) =>
    VoucherMinMaxValueEntity(
      minRange: json['minRange'] as num? ?? 0.0,
      maxRange: json['maxRange'] as num? ?? 0.0,
    );

Map<String, dynamic> _$VoucherMinMaxValueEntityToJson(VoucherMinMaxValueEntity instance) => <String, dynamic>{
      'minRange': instance.minRange,
      'maxRange': instance.maxRange,
    };
