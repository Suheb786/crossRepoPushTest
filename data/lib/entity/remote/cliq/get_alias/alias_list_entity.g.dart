// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alias_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AliasListEntity _$AliasListEntityFromJson(Map<String, dynamic> json) {
  return AliasListEntity(
    aliasID: json['aliasID'] as String? ?? '',
    aliasName: json['aliasName'] as String? ?? '',
    aliasType: json['aliasType'] as String? ?? '',
    status: json['status'] as String? ?? '',
    accounts: (json['accounts'] as List<dynamic>?)
            ?.map((e) => AccountListEntity.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$AliasListEntityToJson(AliasListEntity instance) =>
    <String, dynamic>{
      'aliasID': instance.aliasID,
      'aliasName': instance.aliasName,
      'aliasType': instance.aliasType,
      'status': instance.status,
      'accounts': instance.accounts,
    };
