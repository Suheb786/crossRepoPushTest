// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_credit_card_pin_verify_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeCreditCardPinVerifyRequestEntity
    _$ChangeCreditCardPinVerifyRequestEntityFromJson(
        Map<String, dynamic> json) {
  return ChangeCreditCardPinVerifyRequestEntity(
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
    cardCode: json['CardCode'] as String?,
  );
}

Map<String, dynamic> _$ChangeCreditCardPinVerifyRequestEntityToJson(
        ChangeCreditCardPinVerifyRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'CardCode': instance.cardCode,
      'baseClass': instance.baseData,
    };
