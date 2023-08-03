// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_by_date_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherByDateEntity _$VoucherByDateEntityFromJson(Map<String, dynamic> json) => VoucherByDateEntity(
      json['date'] as String?,
      (json['data'] as List<dynamic>?)
              ?.map((e) => VoucherDetailEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VoucherByDateEntityToJson(VoucherByDateEntity instance) => <String, dynamic>{
      'date': instance.date,
      'data': instance.data,
    };
