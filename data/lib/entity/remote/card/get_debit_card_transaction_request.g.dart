// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_debit_card_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDebitCardTransactionRequest _$GetDebitCardTransactionRequestFromJson(
    Map<String, dynamic> json) {
  return GetDebitCardTransactionRequest(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    isDebit: json['IsDebit'] as bool?,
  );
}

Map<String, dynamic> _$GetDebitCardTransactionRequestToJson(
        GetDebitCardTransactionRequest instance) =>
    <String, dynamic>{
      'IsDebit': instance.isDebit,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
