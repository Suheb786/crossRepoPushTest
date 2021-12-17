// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_issuance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardIssuanceRequest _$CardIssuanceRequestFromJson(Map<String, dynamic> json) {
  return CardIssuanceRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
  );
}

Map<String, dynamic> _$CardIssuanceRequestToJson(
        CardIssuanceRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
