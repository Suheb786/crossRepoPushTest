// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_debit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelDebitCardRequestEntity _$CancelDebitCardRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CancelDebitCardRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      status: json['Status'] as String? ?? "",
      tokenizedPan: json['TokenizedPan'] as String? ?? "",
      cancellationReason: json['CancellationReason'] as String? ?? "",
    );

Map<String, dynamic> _$CancelDebitCardRequestEntityToJson(
        CancelDebitCardRequestEntity instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'TokenizedPan': instance.tokenizedPan,
      'getToken': instance.getToken,
      'CancellationReason': instance.cancellationReason,
      'BaseClass': instance.baseData,
    };
