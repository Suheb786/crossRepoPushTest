// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_post_paid_bill_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPostPaidBillListEntity _$PayPostPaidBillListEntityFromJson(Map<String, dynamic> json) =>
    PayPostPaidBillListEntity(
      billerListEntity: (json['paidBills'] as List<dynamic>?)
          ?.map((e) => BillerListEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PayPostPaidBillListEntityToJson(PayPostPaidBillListEntity instance) =>
    <String, dynamic>{
      'paidBills': instance.billerListEntity,
      'message': instance.message,
    };
