// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitContentEntity _$DebitCardLimitContentEntityFromJson(
    Map<String, dynamic> json) {
  return DebitCardLimitContentEntity(
    limits: (json['limits'] as List<dynamic>?)
        ?.map((e) => DebitCardLimitEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DebitCardLimitContentEntityToJson(
        DebitCardLimitContentEntity instance) =>
    <String, dynamic>{
      'limits': instance.limits,
    };
