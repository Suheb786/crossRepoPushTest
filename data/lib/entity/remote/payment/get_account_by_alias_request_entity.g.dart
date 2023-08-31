// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_alias_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByAliasRequestEntity _$GetAccountByAliasRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetAccountByAliasRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      value: json['Value'] as String?,
      fromAccount: json['FromAccount'] as String?,
      currency: json['Currency'] as String?,
      getToken: json['getToken'] as bool? ?? true,
      beneficiaryId: json['BeneficiaryId'] as String?,
    );

Map<String, dynamic> _$GetAccountByAliasRequestEntityToJson(
        GetAccountByAliasRequestEntity instance) =>
    <String, dynamic>{
      'FromAccount': instance.fromAccount,
      'Value': instance.value,
      'Currency': instance.currency,
      'getToken': instance.getToken,
      'BeneficiaryId': instance.beneficiaryId,
      'baseClass': instance.baseData,
    };
