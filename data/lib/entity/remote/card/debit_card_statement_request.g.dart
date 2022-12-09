// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardStatementRequest _$DebitCardStatementRequestFromJson(
    Map<String, dynamic> json) {
  return DebitCardStatementRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    monthYear: json['MonthYear'] as String?,
  );
}

Map<String, dynamic> _$DebitCardStatementRequestToJson(
        DebitCardStatementRequest instance) =>
    <String, dynamic>{
      'MonthYear': instance.monthYear,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
