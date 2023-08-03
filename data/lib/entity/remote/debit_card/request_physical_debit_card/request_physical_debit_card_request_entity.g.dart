// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_physical_debit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestPhysicalDebitCardRequestEntity _$RequestPhysicalDebitCardRequestEntityFromJson(
        Map<String, dynamic> json) =>
    RequestPhysicalDebitCardRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      tokenizedPan: json['TokenizedPan'] as String? ?? "",
    );

Map<String, dynamic> _$RequestPhysicalDebitCardRequestEntityToJson(
        RequestPhysicalDebitCardRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'TokenizedPan': instance.tokenizedPan,
      'baseClass': instance.baseData,
    };
