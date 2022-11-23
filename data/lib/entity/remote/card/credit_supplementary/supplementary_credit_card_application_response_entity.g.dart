// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_application_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardApplicationResponseEntity _$SupplementaryCreditCardApplicationResponseEntityFromJson(
    Map<String, dynamic> json) {
  return SupplementaryCreditCardApplicationResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SupplementaryCreditCardApplicationResponseEntityToJson(
        SupplementaryCreditCardApplicationResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
