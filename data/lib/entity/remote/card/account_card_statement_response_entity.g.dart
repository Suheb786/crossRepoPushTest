// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_card_statement_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCardStatementResponseEntity _$AccountCardStatementResponseEntityFromJson(
    Map<String, dynamic> json) {
  return AccountCardStatementResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccountCardStatementResponseEntityToJson(
        AccountCardStatementResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
