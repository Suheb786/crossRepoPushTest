// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_alias_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAliasEntity _$GetAliasEntityFromJson(Map<String, dynamic> json) =>
    GetAliasEntity(
      aliases: (json['aliases'] as List<dynamic>?)
          ?.map((e) => AliasListEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAliasEntityToJson(GetAliasEntity instance) =>
    <String, dynamic>{
      'aliases': instance.aliases,
    };
