// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_debit_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelDebitCardRequest _$CancelDebitCardRequestFromJson(
    Map<String, dynamic> json) {
  return CancelDebitCardRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    reason: json['Status'] as String?,
  );
}

Map<String, dynamic> _$CancelDebitCardRequestToJson(
        CancelDebitCardRequest instance) =>
    <String, dynamic>{
      'Status': instance.reason,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
