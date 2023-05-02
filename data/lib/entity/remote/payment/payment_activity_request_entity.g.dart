// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityRequestEntity _$PaymentActivityRequestEntityFromJson(
        Map<String, dynamic> json) =>
    PaymentActivityRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      filterDays: json['filterDays'] as int? ?? 30,
    );

Map<String, dynamic> _$PaymentActivityRequestEntityToJson(
        PaymentActivityRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'filterDays': instance.filterDays,
      'baseClass': instance.baseData,
    };
