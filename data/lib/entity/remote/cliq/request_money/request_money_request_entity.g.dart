// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyRequestEntity _$RequestMoneyRequestEntityFromJson(
    Map<String, dynamic> json) {
  return RequestMoneyRequestEntity(
    cliqType: json['cliqType'] as String?,
    iban: json['iban'] as String?,
    toAccountNo: json['toAccountNo'] as String?,
    alias: json['alias'] as String?,
    mobile: json['mobile'] as String?,
    receipentName: json['receipentName'] as String?,
    amount: json['amount'] as String?,
    currency: json['currency'] as String?,
    rtpPurposeCode: json['rtpPurposeCode'] as String?,
    description: json['description'] as String?,
    beneficiaryId: json['beneficiaryId'] as String?,
    toAccountHolderName: json['toAccountHolderName'] as String?,
    receipentAddress: json['receipentAddress'] as String?,
    getToken: json['getToken'] as bool,
    baseClass: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestMoneyRequestEntityToJson(
        RequestMoneyRequestEntity instance) =>
    <String, dynamic>{
      'cliqType': instance.cliqType,
      'iban': instance.iban,
      'toAccountNo': instance.toAccountNo,
      'alias': instance.alias,
      'mobile': instance.mobile,
      'receipentName': instance.receipentName,
      'amount': instance.amount,
      'currency': instance.currency,
      'rtpPurposeCode': instance.rtpPurposeCode,
      'description': instance.description,
      'beneficiaryId': instance.beneficiaryId,
      'toAccountHolderName': instance.toAccountHolderName,
      'receipentAddress': instance.receipentAddress,
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
