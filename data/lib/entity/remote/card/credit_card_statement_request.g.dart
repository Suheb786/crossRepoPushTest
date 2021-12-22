// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardStatementRequest _$CreditCardStatementRequestFromJson(
    Map<String, dynamic> json) {
  return CreditCardStatementRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    days: json['Days'] as int?,
    accountId: json['AccountId'] as String?,
  );
}

Map<String, dynamic> _$CreditCardStatementRequestToJson(
        CreditCardStatementRequest instance) =>
    <String, dynamic>{
      'Days': instance.days,
      'AccountId': instance.accountId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
