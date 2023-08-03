// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_credit_card_request_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementaryCreditCardRequestResponseEntity
    _$SupplementaryCreditCardRequestResponseEntityFromJson(
            Map<String, dynamic> json) =>
        SupplementaryCreditCardRequestResponseEntity(
          response: json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SupplementaryCreditCardRequestResponseEntityToJson(
        SupplementaryCreditCardRequestResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
