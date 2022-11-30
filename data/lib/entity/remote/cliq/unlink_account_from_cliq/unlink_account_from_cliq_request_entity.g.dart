// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_account_from_cliq_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnLinkAccountFromCliqRequestEntity _$UnLinkAccountFromCliqRequestEntityFromJson(
    Map<String, dynamic> json) {
  return UnLinkAccountFromCliqRequestEntity(
    aliasId: json['aliasId'] as String?,
    accountId: json['accountId'] as String?,
    getToken: json['getToken'] as bool?,
    baseClass: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$UnLinkAccountFromCliqRequestEntityToJson(
        UnLinkAccountFromCliqRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'accountId': instance.accountId,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
