// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_account_from_cliq_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnLinkAccountFromCliqRequestEntity _$UnLinkAccountFromCliqRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UnLinkAccountFromCliqRequestEntity(
      aliasId: json['AliasId'] as String?,
      accountId: json['AccountId'] as String?,
      otpCode: json['OtpCode'] as String?,
      getToken: json['GetToken'] as bool?,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UnLinkAccountFromCliqRequestEntityToJson(
        UnLinkAccountFromCliqRequestEntity instance) =>
    <String, dynamic>{
      'AliasId': instance.aliasId,
      'AccountId': instance.accountId,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
