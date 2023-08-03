// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitEntity _$DebitCardLimitEntityFromJson(Map<String, dynamic> json) => DebitCardLimitEntity(
      description: json['description'] as String?,
      minLimit: json['minLimit'] as String?,
      maxLimit: json['maxLimit'] as String?,
      currentLimit: json['currentLimit'] as String?,
    );

Map<String, dynamic> _$DebitCardLimitEntityToJson(DebitCardLimitEntity instance) => <String, dynamic>{
      'description': instance.description,
      'minLimit': instance.minLimit,
      'currentLimit': instance.currentLimit,
      'maxLimit': instance.maxLimit,
    };
