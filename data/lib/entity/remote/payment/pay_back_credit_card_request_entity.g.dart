// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_back_credit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayBackCreditCardRequestEntity _$PayBackCreditCardRequestEntityFromJson(Map<String, dynamic> json) {
  return PayBackCreditCardRequestEntity(
    payBackAmount: json['PayBackAmount'] as String?,
    secureCode: json['SecureCode'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$PayBackCreditCardRequestEntityToJson(PayBackCreditCardRequestEntity instance) =>
    <String, dynamic>{
      'SecureCode': instance.secureCode,
      'PayBackAmount': instance.payBackAmount,
      'getToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
