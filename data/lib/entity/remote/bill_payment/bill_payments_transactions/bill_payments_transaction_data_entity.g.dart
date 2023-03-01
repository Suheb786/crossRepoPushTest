// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_payments_transaction_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillPaymentsTransactionDataEntity _$BillPaymentsTransactionDataEntityFromJson(
    Map<String, dynamic> json) {
  return BillPaymentsTransactionDataEntity(
    label: json['label'],
    billPaymentsTransactionList: (json['transactionList'] as List<dynamic>?)
        ?.map((e) => BillPaymentsTransactionListEntity.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BillPaymentsTransactionDataEntityToJson(
        BillPaymentsTransactionDataEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'transactionList': instance.billPaymentsTransactionList,
    };
