// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitResponseEntity _$DebitCardLimitResponseEntityFromJson(
        Map<String, dynamic> json) =>
    DebitCardLimitResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DebitCardLimitResponseEntityToJson(
        DebitCardLimitResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
