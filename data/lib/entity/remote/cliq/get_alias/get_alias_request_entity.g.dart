// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_alias_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CliqGetAliasResponseEntity _$CliqGetAliasResponseEntityFromJson(
    Map<String, dynamic> json) {
  return CliqGetAliasResponseEntity(
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CliqGetAliasResponseEntityToJson(
        CliqGetAliasResponseEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
