// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityRequestEntity _$PaymentActivityRequestEntityFromJson(
    Map<String, dynamic> json) {
  return PaymentActivityRequestEntity(
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$PaymentActivityRequestEntityToJson(
        PaymentActivityRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
