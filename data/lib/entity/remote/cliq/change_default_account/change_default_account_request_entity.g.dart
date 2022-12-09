// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_default_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeDefaultAccountRequestEntity _$ChangeDefaultAccountRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ChangeDefaultAccountRequestEntity(
    linkType: json['linkType'] as String,
    otpCode: json['otpCode'] as String,
    identifier: json['identifier'] as String,
    aliasId: json['aliasId'] as String,
    getToken: json['getToken'] as bool,
    baseClass: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ChangeDefaultAccountRequestEntityToJson(
        ChangeDefaultAccountRequestEntity instance) =>
    <String, dynamic>{
      'linkType': instance.linkType,
      'otpCode': instance.otpCode,
      'identifier': instance.identifier,
      'aliasId': instance.aliasId,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
