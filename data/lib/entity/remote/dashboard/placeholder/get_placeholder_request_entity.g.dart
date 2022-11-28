// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_placeholder_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPlaceholderRequestEntity _$GetPlaceholderRequestEntityFromJson(Map<String, dynamic> json) {
  return GetPlaceholderRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    placeholderId: json['PlaceholderId'] as int,
  );
}

Map<String, dynamic> _$GetPlaceholderRequestEntityToJson(GetPlaceholderRequestEntity instance) =>
    <String, dynamic>{
      'PlaceholderId': instance.placeholderId,
      'BaseClass': instance.baseData,
    };
