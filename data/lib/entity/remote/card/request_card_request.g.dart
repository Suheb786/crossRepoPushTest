// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCardRequest _$RequestCardRequestFromJson(Map<String, dynamic> json) {
  return RequestCardRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    cardLimit: (json['CardLimit'] as num?)?.toDouble(),
    accountId: json['AccountId'] as String?,
  );
}

Map<String, dynamic> _$RequestCardRequestToJson(RequestCardRequest instance) =>
    <String, dynamic>{
      'CardLimit': instance.cardLimit,
      'AccountId': instance.accountId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
