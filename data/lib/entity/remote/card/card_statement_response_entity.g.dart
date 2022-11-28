// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_statement_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStatementResponseEntity _$CardStatementResponseEntityFromJson(Map<String, dynamic> json) {
  return CardStatementResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CardStatementResponseEntityToJson(CardStatementResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
