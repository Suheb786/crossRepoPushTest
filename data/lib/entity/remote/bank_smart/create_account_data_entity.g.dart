// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountDataEntity _$CreateAccountDataEntityFromJson(Map<String, dynamic> json) =>
    CreateAccountDataEntity(
      accountDate: json['accountDate'],
      name: json['name'],
      accountNumber: json['accountNumber'],
      iban: json['iban'],
      cif: json['cif'],
      promoCode: json['promoCode'],
      balance: json['balance'],
      currencyCode: json['currencyCode'],
      zPoints: json['zPoints'],
      dailyLimitLeft: json['dailyLimitLeft'],
      dailyTransferLimit: json['dailyTransferLimit'],
      bankName: json['bankName'],
      countryName: json['countryName'],
      swiftCode: json['swiftCode'],
      cardNumber: json['cardNumber'],
    );

Map<String, dynamic> _$CreateAccountDataEntityToJson(CreateAccountDataEntity instance) => <String, dynamic>{
      'accountDate': instance.accountDate,
      'name': instance.name,
      'accountNumber': instance.accountNumber,
      'iban': instance.iban,
      'cif': instance.cif,
      'promoCode': instance.promoCode,
      'balance': instance.balance,
      'currencyCode': instance.currencyCode,
      'zPoints': instance.zPoints,
      'dailyLimitLeft': instance.dailyLimitLeft,
      'dailyTransferLimit': instance.dailyTransferLimit,
      'bankName': instance.bankName,
      'countryName': instance.countryName,
      'swiftCode': instance.swiftCode,
      'cardNumber': instance.cardNumber,
    };
