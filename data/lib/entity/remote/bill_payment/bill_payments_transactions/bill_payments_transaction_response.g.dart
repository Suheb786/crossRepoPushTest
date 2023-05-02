// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_payments_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillPaymentsTransactionResponse _$BillPaymentsTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    BillPaymentsTransactionResponse(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillPaymentsTransactionResponseToJson(
        BillPaymentsTransactionResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
