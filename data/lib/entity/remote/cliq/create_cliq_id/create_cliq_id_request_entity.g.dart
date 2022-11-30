// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCliqIdRequestEntity _$CreateCliqIdRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CreateCliqIdRequestEntity(
    accountNumber: json['accountNumber'] as String?,
    isAlias: json['isAlias'] as bool?,
    aliasValue: json['aliasValue'] as String?,
    getToken: json['getToken'] as bool?,
    baseClass: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$CreateCliqIdRequestEntityToJson(
        CreateCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'isAlias': instance.isAlias,
      'aliasValue': instance.aliasValue,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
