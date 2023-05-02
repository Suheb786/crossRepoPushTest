// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unblock_credit_card_pin_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnblockCreditCardPinRequestEntity _$UnblockCreditCardPinRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UnblockCreditCardPinRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      cardCode: json['CardCode'] as String? ?? "",
    );

Map<String, dynamic> _$UnblockCreditCardPinRequestEntityToJson(
        UnblockCreditCardPinRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'CardCode': instance.cardCode,
      'baseClass': instance.baseData,
    };
