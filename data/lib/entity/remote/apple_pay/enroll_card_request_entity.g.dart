// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enroll_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollCardRequestEntity _$EnrollCardRequestEntityFromJson(
    Map<String, dynamic> json) {
  return EnrollCardRequestEntity(
    getToken: json['GetToken'] as bool?,
    walletId: json['walletId'] as String?,
    cardId: json['cardId'] as String?,
    cardType: json['cardType'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$EnrollCardRequestEntityToJson(
        EnrollCardRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'walletId': instance.walletId,
      'cardId': instance.cardId,
      'cardType': instance.cardType,
      'baseClass': instance.baseData,
    };
