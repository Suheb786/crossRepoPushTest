// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_debit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelDebitCardRequestEntity _$CancelDebitCardRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CancelDebitCardRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    status: json['Status'] as String?,
    tokenizedPan: json['TokenizedPan'] as String?,
  );
}

Map<String, dynamic> _$CancelDebitCardRequestEntityToJson(
        CancelDebitCardRequestEntity instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'TokenizedPan': instance.tokenizedPan,
      'getToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
