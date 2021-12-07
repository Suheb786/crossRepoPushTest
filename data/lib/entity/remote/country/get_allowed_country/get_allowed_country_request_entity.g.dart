// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allowed_country_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllowedCountryRequestEntity _$GetAllowedCountryRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetAllowedCountryRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    content: json['content'] as Map<String, dynamic>?,
    channelId: json['channelId'] as String?,
  );
}

Map<String, dynamic> _$GetAllowedCountryRequestEntityToJson(
        GetAllowedCountryRequestEntity instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'content': instance.content,
      'baseClass': instance.baseData,
    };
