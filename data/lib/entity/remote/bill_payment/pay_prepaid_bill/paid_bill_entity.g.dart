// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_bill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidBillEntity _$PaidBillEntityFromJson(Map<String, dynamic> json) {
  return PaidBillEntity(
    billName: json['billerName'] as String?,
    totalAmount: json['totalAmount'] as String?,
    refNo: json['refNo'] as String?,
    date: json['date'] as String?,
    statusDescription: json['statusDescription'] as String?,
    isPaid: json['isPaid'] as bool?,
  );
}

Map<String, dynamic> _$PaidBillEntityToJson(PaidBillEntity instance) =>
    <String, dynamic>{
      'billerName': instance.billName,
      'totalAmount': instance.totalAmount,
      'refNo': instance.refNo,
      'date': instance.date,
      'statusDescription': instance.statusDescription,
      'isPaid': instance.isPaid,
    };
