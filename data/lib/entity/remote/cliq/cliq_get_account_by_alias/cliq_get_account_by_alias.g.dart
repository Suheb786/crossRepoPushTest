// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliq_get_account_by_alias.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCliqAccountByAliasEntity _$GetCliqAccountByAliasEntityFromJson(
        Map<String, dynamic> json) =>
    GetCliqAccountByAliasEntity(
      type: json['type'] as String?,
      value: json['value'] as String?,
      Currency: json['Currency'] as String?,
      CustID: json['CustID'] as String?,
      GetToken: json['GetToken'] as bool?,
      BaseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetCliqAccountByAliasEntityToJson(
        GetCliqAccountByAliasEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'Currency': instance.Currency,
      'CustID': instance.CustID,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
