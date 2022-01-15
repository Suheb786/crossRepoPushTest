// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitRequestEntity _$DebitCardLimitRequestEntityFromJson(
    Map<String, dynamic> json) {
  return DebitCardLimitRequestEntity(
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$DebitCardLimitRequestEntityToJson(
        DebitCardLimitRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
