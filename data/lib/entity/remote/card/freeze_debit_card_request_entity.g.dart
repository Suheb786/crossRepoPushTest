// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freeze_debit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreezeDebitCardRequestEntity _$FreezeDebitCardRequestEntityFromJson(Map<String, dynamic> json) =>
    FreezeDebitCardRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      status: json['status'] as String? ?? "",
      tokenizedPan: json['TokenizedPan'] as String? ?? "",
    );

Map<String, dynamic> _$FreezeDebitCardRequestEntityToJson(FreezeDebitCardRequestEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'TokenizedPan': instance.tokenizedPan,
      'getToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
