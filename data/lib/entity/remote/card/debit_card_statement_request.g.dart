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
    days: json['NoOfDays'] as int?,
  );
}

Map<String, dynamic> _$DebitCardStatementRequestToJson(
        DebitCardStatementRequest instance) =>
    <String, dynamic>{
      'NoOfDays': instance.days,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
