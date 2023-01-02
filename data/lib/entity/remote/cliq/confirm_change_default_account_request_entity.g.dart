// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_change_default_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmChangeDefaultAccountRequestEntity _$ConfirmChangeDefaultAccountRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ConfirmChangeDefaultAccountRequestEntity(
    aliasId: json['AliasId'] as String,
    acc: json['Acc'] as String,
    getToken: json['GetToken'] as bool,
    baseClass: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ConfirmChangeDefaultAccountRequestEntityToJson(
        ConfirmChangeDefaultAccountRequestEntity instance) =>
    <String, dynamic>{
      'Acc': instance.acc,
      'AliasId': instance.aliasId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
