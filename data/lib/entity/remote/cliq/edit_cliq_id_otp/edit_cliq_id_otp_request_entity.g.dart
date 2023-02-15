// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_cliq_id_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditCliqOtpRequestEntity _$EditCliqOtpRequestEntityFromJson(
    Map<String, dynamic> json) {
  return EditCliqOtpRequestEntity(
    aliasId: json['aliasId'] as String?,
    isAlias: json['isAlias'] as bool?,
    aliasValue: json['aliasValue'] as String?,
    GetToken: json['GetToken'] as bool?,
    baseClass: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$EditCliqOtpRequestEntityToJson(
        EditCliqOtpRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'isAlias': instance.isAlias,
      'aliasValue': instance.aliasValue,
      'GetToken': instance.GetToken,
      'baseClass': instance.baseClass,
    };
