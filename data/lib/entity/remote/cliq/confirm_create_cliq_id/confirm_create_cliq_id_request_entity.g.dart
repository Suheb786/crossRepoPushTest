// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_create_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmCreateCliqIdRequestEntity _$ConfirmCreateCliqIdRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ConfirmCreateCliqIdRequestEntity(
    accountNumber: json['accountNumber'] as String?,
    isAlias: json['isAlias'] as bool?,
    aliasValue: json['aliasValue'] as String?,
    otpCode: json['otpCode'] as String?,
    getToken: json['getToken'] as bool?,
    baseClass: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$ConfirmCreateCliqIdRequestEntityToJson(
        ConfirmCreateCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'aliasValue': instance.aliasValue,
      'otpCode': instance.otpCode,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
