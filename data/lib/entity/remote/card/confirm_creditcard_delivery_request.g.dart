// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_creditcard_delivery_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmCreditCardDeliveryRequest _$ConfirmCreditCardDeliveryRequestFromJson(
    Map<String, dynamic> json) {
  return ConfirmCreditCardDeliveryRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    accountId: json['AccountId'] as int?,
  );
}

Map<String, dynamic> _$ConfirmCreditCardDeliveryRequestToJson(
        ConfirmCreditCardDeliveryRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'AccountId': instance.accountId,
      'baseClass': instance.baseData,
    };
