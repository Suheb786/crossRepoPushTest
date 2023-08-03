// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_transaction_list_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardTransactionListRequestEntity _$GetCreditCardTransactionListRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetCreditCardTransactionListRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      noOfDays: json['NoOfDays'] as num? ?? 180,
      cardId: json['CardId'] as String? ?? "",
    );

Map<String, dynamic> _$GetCreditCardTransactionListRequestEntityToJson(
        GetCreditCardTransactionListRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'NoOfDays': instance.noOfDays,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
