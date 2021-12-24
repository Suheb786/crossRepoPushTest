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
    monthYear: json['MonthYear'] as String?,
  );
}

Map<String, dynamic> _$CreditCardStatementRequestToJson(
        CreditCardStatementRequest instance) =>
    <String, dynamic>{
      'MonthYear': instance.monthYear,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
