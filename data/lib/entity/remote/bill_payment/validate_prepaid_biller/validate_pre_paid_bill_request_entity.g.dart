// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_pre_paid_bill_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePrePaidBillRequestEntity _$ValidatePrePaidBillRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ValidatePrePaidBillRequestEntity(
    billerCode: json['billerCode'] as String?,
    amount: json['amount'] as String?,
    serviceType: json['serviceType'] as String?,
    billingNumber: json['billingNumber'] as String?,
    prepaidCategoryCode: json['prepaidCategoryCode'] as String?,
    prepaidCategoryType: json['prepaidCategoryType'] as String?,
    billingNumberRequired: json['billingNumberRequired'] as bool?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ValidatePrePaidBillRequestEntityToJson(
        ValidatePrePaidBillRequestEntity instance) =>
    <String, dynamic>{
      'billerCode': instance.billerCode,
      'amount': instance.amount,
      'serviceType': instance.serviceType,
      'billingNumber': instance.billingNumber,
      'prepaidCategoryCode': instance.prepaidCategoryCode,
      'prepaidCategoryType': instance.prepaidCategoryType,
      'billingNumberRequired': instance.billingNumberRequired,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
