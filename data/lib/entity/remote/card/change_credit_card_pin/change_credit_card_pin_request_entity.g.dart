// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_credit_card_pin_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeCreditCardPinRequestEntity _$ChangeCreditCardPinRequestEntityFromJson(Map<String, dynamic> json) =>
    ChangeCreditCardPinRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>?,
      cardCode: json['CardCode'] as String? ?? "",
      encryptedCardNumber: json['EncryptedCardNumber'] as String? ?? "",
      encryptedPinCode: json['EncryptedPinCode'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
    );

Map<String, dynamic> _$ChangeCreditCardPinRequestEntityToJson(ChangeCreditCardPinRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'CardCode': instance.cardCode,
      'EncryptedPinCode': instance.encryptedPinCode,
      'EncryptedCardNumber': instance.encryptedCardNumber,
      'otp': instance.otp,
      'baseClass': instance.baseData,
    };
