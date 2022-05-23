// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_limit_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardLimitResponseEntity _$GetCreditCardLimitResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetCreditCardLimitResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetCreditCardLimitResponseEntityToJson(
        GetCreditCardLimitResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
