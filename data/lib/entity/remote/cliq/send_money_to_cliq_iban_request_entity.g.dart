// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_money_to_cliq_iban_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMoneyToCliqIbanRequestEntity _$SendMoneyToCliqIbanRequestEntityFromJson(
    Map<String, dynamic> json) {
  return SendMoneyToCliqIbanRequestEntity(
    otpCode: json['otpCode'] as String?,
    transferType: json['transferType'] as String?,
    cliqType: json['cliqType'] as String?,
    toIban: json['toIban'] as String?,
    toAccountNo: json['toAccountNo'] as String?,
    toAlias: json['toAlias'] as String?,
    toMobileNo: json['toMobileNo'] as String?,
    toBankCountry: json['toBankCountry'] as String?,
    swift: json['swift'] as String?,
    routingNO: json['routingNO'] as String?,
    recipientName: json['recipientName'] as String?,
    fromAccountNo: json['fromAccountNo'] as String?,
    transferAmount: json['transferAmount'] as String?,
    fromAccountCurrency: json['fromAccountCurrency'] as String?,
    toAccountCurrency: json['toAccountCurrency'] as String?,
    Charges: json['Charges'] as bool?,
    TransferPurposeCode: json['TransferPurposeCode'] as String?,
    description: json['description'] as String?,
    whenToSend: json['whenToSend'] as String?,
    beneficiaryId: json['beneficiaryId'] as String?,
    fromCardId: json['fromCardId'],
    fromCardType: json['fromCardType'],
    ownAccountTransferType: json['ownAccountTransferType'],
    fromAccountHolderName: json['fromAccountHolderName'] as String?,
    recipientAddress: json['recipientAddress'] as String?,
    flagAmount: json['flagAmount'] as String?,
    flagCurrency: json['flagCurrency'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SendMoneyToCliqIbanRequestEntityToJson(
        SendMoneyToCliqIbanRequestEntity instance) =>
    <String, dynamic>{
      'otpCode': instance.otpCode,
      'transferType': instance.transferType,
      'cliqType': instance.cliqType,
      'toIban': instance.toIban,
      'toAccountNo': instance.toAccountNo,
      'toAlias': instance.toAlias,
      'toMobileNo': instance.toMobileNo,
      'toBankCountry': instance.toBankCountry,
      'swift': instance.swift,
      'routingNO': instance.routingNO,
      'recipientName': instance.recipientName,
      'fromAccountNo': instance.fromAccountNo,
      'transferAmount': instance.transferAmount,
      'fromAccountCurrency': instance.fromAccountCurrency,
      'toAccountCurrency': instance.toAccountCurrency,
      'Charges': instance.Charges,
      'TransferPurposeCode': instance.TransferPurposeCode,
      'description': instance.description,
      'whenToSend': instance.whenToSend,
      'beneficiaryId': instance.beneficiaryId,
      'fromCardId': instance.fromCardId,
      'fromCardType': instance.fromCardType,
      'ownAccountTransferType': instance.ownAccountTransferType,
      'fromAccountHolderName': instance.fromAccountHolderName,
      'recipientAddress': instance.recipientAddress,
      'flagAmount': instance.flagAmount,
      'flagCurrency': instance.flagCurrency,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
