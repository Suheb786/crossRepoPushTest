// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_relationship_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardRelationshipResponseEntity
    _$CreditCardRelationshipResponseEntityFromJson(Map<String, dynamic> json) =>
        CreditCardRelationshipResponseEntity(
          response: json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CreditCardRelationshipResponseEntityToJson(
        CreditCardRelationshipResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
