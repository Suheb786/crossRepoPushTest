// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_issuance_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardIssuanceResponseEntity _$CardIssuanceResponseEntityFromJson(Map<String, dynamic> json) =>
    CardIssuanceResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardIssuanceResponseEntityToJson(CardIssuanceResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
