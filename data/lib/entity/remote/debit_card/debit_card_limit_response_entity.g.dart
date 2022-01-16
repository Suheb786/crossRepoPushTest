// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitResponseEntity _$DebitCardLimitResponseEntityFromJson(
    Map<String, dynamic> json) {
  return DebitCardLimitResponseEntity(
    debitCardLimitContentEntity: json['content'] == null
        ? null
        : DebitCardLimitContentEntity.fromJson(
            json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DebitCardLimitResponseEntityToJson(
        DebitCardLimitResponseEntity instance) =>
    <String, dynamic>{
      'content': instance.debitCardLimitContentEntity,
    };
