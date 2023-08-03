// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_debit_card_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDebitCardTransactionRequest _$GetDebitCardTransactionRequestFromJson(
        Map<String, dynamic> json) =>
    GetDebitCardTransactionRequest(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      noOfDays: json['NoOfDays'] as num? ?? 90,
      getToken: json['GetToken'] as bool? ?? true,
      isDebit: json['IsDebit'] as bool? ?? true,
    );

Map<String, dynamic> _$GetDebitCardTransactionRequestToJson(
        GetDebitCardTransactionRequest instance) =>
    <String, dynamic>{
      'IsDebit': instance.isDebit,
      'NoOfDays': instance.noOfDays,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
