// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freeze_credit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreezeCreditCardRequestEntity _$FreezeCreditCardRequestEntityFromJson(
    Map<String, dynamic> json) {
  return FreezeCreditCardRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
  );
}

Map<String, dynamic> _$FreezeCreditCardRequestEntityToJson(
        FreezeCreditCardRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
