// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_to_account_transfer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountToAccountTransferEntity _$AccountToAccountTransferEntityFromJson(
        Map<String, dynamic> json) =>
    AccountToAccountTransferEntity(
      transferAmount: (json['amount'] as num).toDouble(),
      accountName: json['name'] as String,
      accountIban: json['iban'] as String,
      transferDateTime: json['transferDate'] as String,
      transferReference: json['reference'] as String,
    );

Map<String, dynamic> _$AccountToAccountTransferEntityToJson(
        AccountToAccountTransferEntity instance) =>
    <String, dynamic>{
      'amount': instance.transferAmount,
      'name': instance.accountName,
      'iban': instance.accountIban,
      'transferDate': instance.transferDateTime,
      'reference': instance.transferReference,
    };
