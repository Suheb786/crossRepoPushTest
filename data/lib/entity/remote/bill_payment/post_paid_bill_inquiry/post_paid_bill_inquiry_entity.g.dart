// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_paid_bill_inquiry_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaidBillInquiryEntity _$PostPaidBillInquiryEntityFromJson(
    Map<String, dynamic> json) {
  return PostPaidBillInquiryEntity(
    serviceType: json['serviceType'] as String?,
    billerCode: json['billerCode'] as String?,
    message: json['message'],
    success: json['success'] as bool?,
    billingNo: json['billingNo'] as String?,
    billNo: json['billNo'] as String?,
    dueAmount: json['dueAmount'],
    dueDate: json['dueDate'] as String?,
    feesAmt: json['feesAmt'],
    isPartial: json['isPartial'] as bool?,
    minValue: json['minValue'],
    maxValue: json['maxValue'],
    inqRefNo: json['inqRefNo'],
  );
}

Map<String, dynamic> _$PostPaidBillInquiryEntityToJson(
        PostPaidBillInquiryEntity instance) =>
    <String, dynamic>{
      'billerCode': instance.billerCode,
      'billingNo': instance.billingNo,
      'billNo': instance.billNo,
      'dueDate': instance.dueDate,
      'serviceType': instance.serviceType,
      'dueAmount': instance.dueAmount,
      'feesAmt': instance.feesAmt,
      'success': instance.success,
      'message': instance.message,
      'isPartial': instance.isPartial,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'inqRefNo': instance.inqRefNo,
    };
