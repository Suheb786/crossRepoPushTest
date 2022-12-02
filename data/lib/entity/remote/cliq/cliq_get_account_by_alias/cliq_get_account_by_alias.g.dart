// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliq_get_account_by_alias.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCliqAccountByAliasEntity _$GetCliqAccountByAliasEntityFromJson(
    Map<String, dynamic> json) {
  return GetCliqAccountByAliasEntity(
    alias: json['alias'] as String?,
    mobileNo: json['mobileNo'] as String?,
    iban: json['iban'] as String?,
    accountNo: json['accountNo'] as String?,
    swiftCode: json['swiftCode'] as String?,
    bankCountry: json['bankCountry'] as String?,
    transferType: json['transferType'] as String?,
    cliqType: json['cliqType'] as String?,
    getToken: json['getToken'] as bool?,
    baseClass: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetCliqAccountByAliasEntityToJson(
        GetCliqAccountByAliasEntity instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'mobileNo': instance.mobileNo,
      'iban': instance.iban,
      'accountNo': instance.accountNo,
      'swiftCode': instance.swiftCode,
      'bankCountry': instance.bankCountry,
      'transferType': instance.transferType,
      'cliqType': instance.cliqType,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
