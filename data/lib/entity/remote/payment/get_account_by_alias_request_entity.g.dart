// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_alias_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByAliasRequestEntity _$GetAccountByAliasRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetAccountByAliasRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    value: json['Value'] as String?,
    currency: json['Currency'] as String?,
    getToken: json['getToken'] as bool,
  );
}

Map<String, dynamic> _$GetAccountByAliasRequestEntityToJson(
        GetAccountByAliasRequestEntity instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Currency': instance.currency,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
