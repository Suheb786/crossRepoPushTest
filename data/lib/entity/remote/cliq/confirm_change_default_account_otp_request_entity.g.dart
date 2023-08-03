// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_change_default_account_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmChangeDefaultAccountOtpRequestEntity _$ConfirmChangeDefaultAccountOtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ConfirmChangeDefaultAccountOtpRequestEntity(
      aliasId: json['AliasId'] as String,
      acc: json['Acc'] as String,
      getToken: json['GetToken'] as bool,
      baseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ConfirmChangeDefaultAccountOtpRequestEntityToJson(
        ConfirmChangeDefaultAccountOtpRequestEntity instance) =>
    <String, dynamic>{
      'Acc': instance.acc,
      'AliasId': instance.aliasId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
