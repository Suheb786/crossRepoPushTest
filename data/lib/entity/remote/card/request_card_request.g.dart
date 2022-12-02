// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCardRequest _$RequestCardRequestFromJson(Map<String, dynamic> json) {
  return RequestCardRequest(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
  );
}

Map<String, dynamic> _$RequestCardRequestToJson(RequestCardRequest instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
