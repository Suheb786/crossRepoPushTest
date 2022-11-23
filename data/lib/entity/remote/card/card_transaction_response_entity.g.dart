// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_transaction_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardTransactionResponseEntity _$CardTransactionResponseEntityFromJson(Map<String, dynamic> json) {
  return CardTransactionResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CardTransactionResponseEntityToJson(CardTransactionResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
