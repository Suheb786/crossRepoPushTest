// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_transaction_history_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryTransactionHistoryRequest _$BeneficiaryTransactionHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    BeneficiaryTransactionHistoryRequest(
      beneficiaryId: json['BeneficiaryId'] as String,
      filterDays: json['FilterDays'] as num,
      pageNo: json['PageNo'] as int,
      transactionType: json['TransactionType'] as String,
      searchText: json['searchText'] as String,
      totalRecords: json['TotalRecords'] as String,
      isFromMobile: json['IsFromMobile'] as bool,
      getToken: json['GetToken'] as bool,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BeneficiaryTransactionHistoryRequestToJson(
        BeneficiaryTransactionHistoryRequest instance) =>
    <String, dynamic>{
      'BeneficiaryId': instance.beneficiaryId,
      'FilterDays': instance.filterDays,
      'PageNo': instance.pageNo,
      'TransactionType': instance.transactionType,
      'TotalRecords': instance.totalRecords,
      'searchText': instance.searchText,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
