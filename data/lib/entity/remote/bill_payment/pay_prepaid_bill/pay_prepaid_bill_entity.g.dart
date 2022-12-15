// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_prepaid_bill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPrePaidBillEntity _$PayPrePaidBillEntityFromJson(Map<String, dynamic> json) {
  return PayPrePaidBillEntity(
    message: json['message'] as String?,
    paidBills: (json['paidBills'] as List<dynamic>?)
        ?.map((e) => PaidBillEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PayPrePaidBillEntityToJson(
        PayPrePaidBillEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'paidBills': instance.paidBills,
    };
