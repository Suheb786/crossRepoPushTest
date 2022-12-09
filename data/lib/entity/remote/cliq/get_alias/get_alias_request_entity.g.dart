// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_alias_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CliqGetAliasRequestEntity _$CliqGetAliasRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CliqGetAliasRequestEntity(
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CliqGetAliasRequestEntityToJson(
        CliqGetAliasRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
