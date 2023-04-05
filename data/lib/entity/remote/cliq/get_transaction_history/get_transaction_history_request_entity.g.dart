// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_history_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionHistoryRequestEntity _$GetTransactionHistoryRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetTransactionHistoryRequestEntity(
    FilterDays: json['FilterDays'] as String?,
    TransactionType: json['TransactionType'] as String?,
    TotalRecords: json['TotalRecords'] as String?,
    GetToken: json['GetToken'] as bool?,
    BaseClass: json['BaseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$GetTransactionHistoryRequestEntityToJson(
        GetTransactionHistoryRequestEntity instance) =>
    <String, dynamic>{
      'FilterDays': instance.FilterDays,
      'TransactionType': instance.TransactionType,
      'TotalRecords': instance.TotalRecords,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
