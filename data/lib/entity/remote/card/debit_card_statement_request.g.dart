// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardStatementRequest _$DebitCardStatementRequestFromJson(
        Map<String, dynamic> json) =>
    DebitCardStatementRequest(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      monthYear: json['MonthYear'] as String? ?? "",
      accountNo: json['AccountNo'] as String?,
    );

Map<String, dynamic> _$DebitCardStatementRequestToJson(
        DebitCardStatementRequest instance) =>
    <String, dynamic>{
      'AccountNo': instance.accountNo,
      'MonthYear': instance.monthYear,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
