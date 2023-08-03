// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_limit_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardLimitRequestEntity _$CreditCardLimitRequestEntityFromJson(Map<String, dynamic> json) =>
    CreditCardLimitRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>?,
      secureCode: json['SecureCode'] as String? ?? "",
    );

Map<String, dynamic> _$CreditCardLimitRequestEntityToJson(CreditCardLimitRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'SecureCode': instance.secureCode,
      'BaseClass': instance.baseData,
    };
