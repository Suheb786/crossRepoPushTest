// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_create_cliq_id_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmCreateCliqIdEntity _$ConfirmCreateCliqIdEntityFromJson(
        Map<String, dynamic> json) =>
    ConfirmCreateCliqIdEntity(
      transferType: json['transferType'] as String? ?? '',
      cliqType: json['cliqType'] as String? ?? '',
      iban: json['iban'] as String? ?? '',
      accountNo: json['accountNo'] as String? ?? '',
      mobileNo: json['mobileNo'] as String? ?? '',
      alias: json['alias'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      bankAddress: json['bankAddress'] as String? ?? '',
      bankCountry: json['bankCountry'] as String? ?? '',
      swiftCode: json['swiftCode'] as String? ?? '',
      accountTittle: json['accountTittle'] as String? ?? '',
      accountType: json['accountType'] as String? ?? '',
      country: json['country'] as String? ?? '',
      city: json['city'] as String? ?? '',
      stateProvinceRegion: json['stateProvinceRegion'] as String? ?? '',
      address: json['address'] as String? ?? '',
      currencyCode: json['currencyCode'] as String? ?? '',
    );

Map<String, dynamic> _$ConfirmCreateCliqIdEntityToJson(
        ConfirmCreateCliqIdEntity instance) =>
    <String, dynamic>{
      'transferType': instance.transferType,
      'cliqType': instance.cliqType,
      'iban': instance.iban,
      'accountNo': instance.accountNo,
      'mobileNo': instance.mobileNo,
      'alias': instance.alias,
      'bankName': instance.bankName,
      'bankAddress': instance.bankAddress,
      'bankCountry': instance.bankCountry,
      'swiftCode': instance.swiftCode,
      'accountTittle': instance.accountTittle,
      'accountType': instance.accountType,
      'country': instance.country,
      'city': instance.city,
      'stateProvinceRegion': instance.stateProvinceRegion,
      'address': instance.address,
      'currencyCode': instance.currencyCode,
    };
