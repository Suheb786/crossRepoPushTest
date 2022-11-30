// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_link_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLinkAccountRequestEntity _$AddLinkAccountRequestEntityFromJson(
    Map<String, dynamic> json) {
  return AddLinkAccountRequestEntity(
    aliasId: json['aliasId'] as String,
    linkType: json['linkType'] as String,
    accountNumber: json['accountNumber'] as String,
    isAlias: json['isAlias'] as bool,
    aliasValue: json['aliasValue'] as String,
    getToken: json['getToken'] as bool,
    baseClass: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AddLinkAccountRequestEntityToJson(
        AddLinkAccountRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'linkType': instance.linkType,
      'accountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'aliasValue': instance.aliasValue,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
