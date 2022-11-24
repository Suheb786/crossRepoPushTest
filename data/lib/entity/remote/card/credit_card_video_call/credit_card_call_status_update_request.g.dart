// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_call_status_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardCallStatusUpdateRequest _$CreditCardCallStatusUpdateRequestFromJson(Map<String, dynamic> json) {
  return CreditCardCallStatusUpdateRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
    status: json['Status'] as String?,
  );
}

Map<String, dynamic> _$CreditCardCallStatusUpdateRequestToJson(CreditCardCallStatusUpdateRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'CardId': instance.cardId,
      'Status': instance.status,
      'baseClass': instance.baseData,
    };
