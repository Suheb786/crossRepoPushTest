// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_bill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidBillEntity _$PaidBillEntityFromJson(Map<String, dynamic> json) =>
    PaidBillEntity(
      billName: json['billerName'] as String?,
      billerNameAR: json['billerNameAR'] as String?,
      totalAmount: json['totalAmount'] as String?,
      fee: json['fee'] as String?,
      refNo: json['refNo'] as String?,
      date: json['date'] as String?,
      statusDescription: json['statusDescription'] as String?,
      isPaid: json['isPaid'] as bool?,
    );

Map<String, dynamic> _$PaidBillEntityToJson(PaidBillEntity instance) =>
    <String, dynamic>{
      'billerName': instance.billName,
      'billerNameAR': instance.billerNameAR,
      'totalAmount': instance.totalAmount,
      'fee': instance.fee,
      'refNo': instance.refNo,
      'date': instance.date,
      'statusDescription': instance.statusDescription,
      'isPaid': instance.isPaid,
    };
