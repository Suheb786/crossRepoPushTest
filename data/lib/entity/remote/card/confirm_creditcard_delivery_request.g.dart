// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_creditcard_delivery_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmCreditCardDeliveryRequest _$ConfirmCreditCardDeliveryRequestFromJson(Map<String, dynamic> json) {
  return ConfirmCreditCardDeliveryRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    accountId: json['AccountId'] as String?,
    cardId: json['CardId'] as String?,
    cardDigit: json['CardDigit'] as String?,
  );
}

Map<String, dynamic> _$ConfirmCreditCardDeliveryRequestToJson(ConfirmCreditCardDeliveryRequest instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'CardDigit': instance.cardDigit,
      'GetToken': instance.getToken,
      'AccountId': instance.accountId,
      'baseClass': instance.baseData,
    };
