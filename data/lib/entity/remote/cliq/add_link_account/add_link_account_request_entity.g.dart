// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_link_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLinkAccountRequestEntity _$AddLinkAccountRequestEntityFromJson(Map<String, dynamic> json) =>
    AddLinkAccountRequestEntity(
      aliasId: json['AliasId'] as String,
      linkType: json['LinkType'] as String,
      accountNumber: json['AccountNumber'] as String,
      isAlias: json['isAlias'] as bool,
      aliasValue: json['AliasValue'] as String,
      otpCode: json['OtpCode'] as String,
      getToken: json['GetToken'] as bool,
      baseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddLinkAccountRequestEntityToJson(AddLinkAccountRequestEntity instance) =>
    <String, dynamic>{
      'AliasId': instance.aliasId,
      'LinkType': instance.linkType,
      'AccountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'AliasValue': instance.aliasValue,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
