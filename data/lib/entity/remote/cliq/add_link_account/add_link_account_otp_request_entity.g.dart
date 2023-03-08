// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_link_account_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLinkAccountOtpRequestEntity _$AddLinkAccountOtpRequestEntityFromJson(
    Map<String, dynamic> json) {
  return AddLinkAccountOtpRequestEntity(
    aliasId: json['AliasId'] as String,
    linkType: json['LinkType'] as String,
    accountNumber: json['AccountNumber'] as String,
    isAlias: json['isAlias'] as bool,
    aliasValue: json['AliasValue'] as String,
    getToken: json['GetToken'] as bool,
    baseClass: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AddLinkAccountOtpRequestEntityToJson(
        AddLinkAccountOtpRequestEntity instance) =>
    <String, dynamic>{
      'AliasId': instance.aliasId,
      'LinkType': instance.linkType,
      'AccountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'AliasValue': instance.aliasValue,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
