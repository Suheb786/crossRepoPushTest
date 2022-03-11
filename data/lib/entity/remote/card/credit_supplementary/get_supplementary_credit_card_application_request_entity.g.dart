// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplementary_credit_card_application_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSupplementaryCreditCardApplicationRequestEntity
    _$GetSupplementaryCreditCardApplicationRequestEntityFromJson(
        Map<String, dynamic> json) {
  return GetSupplementaryCreditCardApplicationRequestEntity(
    primaryCard: json['PrimaryCard'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetSupplementaryCreditCardApplicationRequestEntityToJson(
        GetSupplementaryCreditCardApplicationRequestEntity instance) =>
    <String, dynamic>{
      'PrimaryCard': instance.primaryCard,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
