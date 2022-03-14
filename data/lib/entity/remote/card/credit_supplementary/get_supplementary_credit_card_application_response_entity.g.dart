// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplementary_credit_card_application_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSupplementaryCreditCardApplicationResponseEntity
    _$GetSupplementaryCreditCardApplicationResponseEntityFromJson(
        Map<String, dynamic> json) {
  return GetSupplementaryCreditCardApplicationResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic>
    _$GetSupplementaryCreditCardApplicationResponseEntityToJson(
            GetSupplementaryCreditCardApplicationResponseEntity instance) =>
        <String, dynamic>{
          'response': instance.response,
        };
