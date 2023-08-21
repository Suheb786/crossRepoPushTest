// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freeze_credit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreezeCreditCardRequestEntity _$FreezeCreditCardRequestEntityFromJson(
        Map<String, dynamic> json) =>
    FreezeCreditCardRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      cardId: json['CardId'] as String? ?? "",
      secureCode: json['SecureCode'] as String? ?? '',
      issuedFromCms: json['IssuedFromCms'] as bool? ?? false,
    );

Map<String, dynamic> _$FreezeCreditCardRequestEntityToJson(
        FreezeCreditCardRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'GetToken': instance.getToken,
      'SecureCode': instance.secureCode,
      'IssuedFromCms': instance.issuedFromCms,
      'BaseClass': instance.baseData,
    };
