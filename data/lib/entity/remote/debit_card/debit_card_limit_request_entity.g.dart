// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limit_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardLimitRequestEntity _$DebitCardLimitRequestEntityFromJson(Map<String, dynamic> json) =>
    DebitCardLimitRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      tokenizedPan: json['TokenizedPan'] as String? ?? "",
    );

Map<String, dynamic> _$DebitCardLimitRequestEntityToJson(DebitCardLimitRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'TokenizedPan': instance.tokenizedPan,
      'baseClass': instance.baseData,
    };
