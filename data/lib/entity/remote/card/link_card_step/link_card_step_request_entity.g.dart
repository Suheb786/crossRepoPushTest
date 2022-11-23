// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_card_step_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkCardStepRequestEntity _$LinkCardStepRequestEntityFromJson(Map<String, dynamic> json) {
  return LinkCardStepRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
    accountNumber: json['AccountNumber'] as String?,
  );
}

Map<String, dynamic> _$LinkCardStepRequestEntityToJson(LinkCardStepRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'AccountNumber': instance.accountNumber,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
