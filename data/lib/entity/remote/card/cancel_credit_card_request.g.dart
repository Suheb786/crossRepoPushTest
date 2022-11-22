// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_credit_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelCreditCardRequest _$CancelCreditCardRequestFromJson(Map<String, dynamic> json) {
  return CancelCreditCardRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    reason: json['Reason'] as String?,
  );
}

Map<String, dynamic> _$CancelCreditCardRequestToJson(CancelCreditCardRequest instance) => <String, dynamic>{
      'Reason': instance.reason,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
