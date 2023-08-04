// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_account_from_cliq_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnLinkAccountFromCliqOtpRequestEntity
    _$UnLinkAccountFromCliqOtpRequestEntityFromJson(
            Map<String, dynamic> json) =>
        UnLinkAccountFromCliqOtpRequestEntity(
          aliasId: json['AliasId'] as String?,
          accountId: json['AccountId'] as String?,
          getToken: json['GetToken'] as bool?,
          baseClass: json['BaseClass'] as Map<String, dynamic>?,
        );

Map<String, dynamic> _$UnLinkAccountFromCliqOtpRequestEntityToJson(
        UnLinkAccountFromCliqOtpRequestEntity instance) =>
    <String, dynamic>{
      'AliasId': instance.aliasId,
      'AccountId': instance.accountId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
