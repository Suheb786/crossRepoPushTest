// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_relationship_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardRelationshipRequestEntity
    _$GetCreditCardRelationshipRequestEntityFromJson(
            Map<String, dynamic> json) =>
        GetCreditCardRelationshipRequestEntity(
          cardId: json['CardId'] as String?,
          getToken: json['GetToken'] as bool? ?? false,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$GetCreditCardRelationshipRequestEntityToJson(
        GetCreditCardRelationshipRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
