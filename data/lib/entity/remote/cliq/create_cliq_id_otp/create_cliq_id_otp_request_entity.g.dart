// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cliq_id_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCliqIdOtpRequestEntity _$CreateCliqIdOtpRequestEntityFromJson(Map<String, dynamic> json) =>
    CreateCliqIdOtpRequestEntity(
      accountNumber: json['accountNumber'] as String?,
      isAlias: json['isAlias'] as bool?,
      aliasValue: json['aliasValue'] as String?,
      getToken: json['getToken'] as bool?,
      baseClass: json['baseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateCliqIdOtpRequestEntityToJson(CreateCliqIdOtpRequestEntity instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'aliasValue': instance.aliasValue,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
