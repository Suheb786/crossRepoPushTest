// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_pre_paid_bill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePrePaidBillEntity _$ValidatePrePaidBillEntityFromJson(
    Map<String, dynamic> json) {
  return ValidatePrePaidBillEntity(
    success: json['success'],
    message: json['message'],
    billerCode: json['billerCode'],
    billingNo: json['billingNo'],
    customerName: json['customerName'],
    dueAmount: json['dueAmount'],
    feesAmount: json['feesAmount'],
    validationCode: json['validationCode'],
  );
}

Map<String, dynamic> _$ValidatePrePaidBillEntityToJson(
        ValidatePrePaidBillEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'billerCode': instance.billerCode,
      'billingNo': instance.billingNo,
      'customerName': instance.customerName,
      'dueAmount': instance.dueAmount,
      'feesAmount': instance.feesAmount,
      'validationCode': instance.validationCode,
    };
