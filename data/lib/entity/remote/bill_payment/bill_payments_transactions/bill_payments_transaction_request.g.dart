// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_payments_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillPaymentsTransactionRequest _$BillPaymentsTransactionRequestFromJson(Map<String, dynamic> json) {
  return BillPaymentsTransactionRequest(
    pageSize: json['PageSize'] as num?,
    pageNo: json['PageNo'] as num?,
    type: json['type'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$BillPaymentsTransactionRequestToJson(BillPaymentsTransactionRequest instance) =>
    <String, dynamic>{
      'PageSize': instance.pageSize,
      'PageNo': instance.pageNo,
      'type': instance.type,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
