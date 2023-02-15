// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_payments_transaction_bill_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillPaymentsTransactionListEntity _$BillPaymentsTransactionListEntityFromJson(Map<String, dynamic> json) {
  return BillPaymentsTransactionListEntity(
    nickname: json['nickname'] as String?,
    billingNumber: json['billingNumber'] as String?,
    billerName: json['billerName'] as String?,
    billerNameAr: json['billerNameAr'] as String?,
    billerCode: json['billerCode'] as String?,
    billNo: json['billNo'] as String?,
    amount: json['amount'] as String?,
    fees: json['fees'] as String?,
    paymentDate: json['paymentDate'] as String?,
    serviceCode: json['serviceCode'] as String?,
    serviceType: json['serviceType'] as String?,
    categoryName: json['categoryName'] as String?,
    iconCode: json['iconCode'] as String?,
    refNo: json['transactionRefrenceNo'] as String?,
    status: json['status'] as int?,
  );
}

Map<String, dynamic> _$BillPaymentsTransactionListEntityToJson(BillPaymentsTransactionListEntity instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'billingNumber': instance.billingNumber,
      'billerName': instance.billerName,
      'billerNameAr': instance.billerNameAr,
      'billerCode': instance.billerCode,
      'billNo': instance.billNo,
      'amount': instance.amount,
      'fees': instance.fees,
      'paymentDate': instance.paymentDate,
      'serviceType': instance.serviceType,
      'serviceCode': instance.serviceCode,
      'categoryName': instance.categoryName,
      'iconCode': instance.iconCode,
      'transactionRefrenceNo': instance.refNo,
      'status': instance.status,
    };
