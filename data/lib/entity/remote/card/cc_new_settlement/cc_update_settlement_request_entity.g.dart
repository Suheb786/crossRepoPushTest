// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cc_update_settlement_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CcUpdateSettlementRequestEntity _$CcUpdateSettlementRequestEntityFromJson(Map<String, dynamic> json) {
  return CcUpdateSettlementRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
    rate: json['Rate'] as num?,
  );
}

Map<String, dynamic> _$CcUpdateSettlementRequestEntityToJson(CcUpdateSettlementRequestEntity instance) =>
    <String, dynamic>{
      'Rate': instance.rate,
      'CardId': instance.cardId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
