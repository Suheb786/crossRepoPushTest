// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardStatementRequest _$CreditCardStatementRequestFromJson(
        Map<String, dynamic> json) =>
    CreditCardStatementRequest(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      date: json['Date'] as String? ?? '',
      cardId: json['CardId'] as String? ?? "",
      secureCode: json['SecureCode'] as String? ?? '',
      issuedFromCms: json['IssuedFromCms'] as bool? ?? false,
    );

Map<String, dynamic> _$CreditCardStatementRequestToJson(
        CreditCardStatementRequest instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'CardId': instance.cardId,
      'getToken': instance.getToken,
      'SecureCode': instance.secureCode,
      'IssuedFromCms': instance.issuedFromCms,
      'baseClass': instance.baseData,
    };
