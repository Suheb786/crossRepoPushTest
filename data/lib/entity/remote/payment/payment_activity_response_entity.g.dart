// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityResponseEntity _$PaymentActivityResponseEntityFromJson(
    Map<String, dynamic> json) {
  return PaymentActivityResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PaymentActivityResponseEntityToJson(
        PaymentActivityResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
