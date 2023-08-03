// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequestEntity _$CreateAccountRequestEntityFromJson(Map<String, dynamic> json) =>
    CreateAccountRequestEntity(
      getToken: json['getToken'] as bool? ?? true,
      cif: json['cif'] as String?,
      customerDetailsEntity: json['customer'] as Map<String, dynamic>?,
      account: json['account'] as Map<String, dynamic>?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CreateAccountRequestEntityToJson(CreateAccountRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'cif': instance.cif,
      'customer': instance.customerDetailsEntity,
      'account': instance.account,
      'baseClass': instance.baseData,
    };
