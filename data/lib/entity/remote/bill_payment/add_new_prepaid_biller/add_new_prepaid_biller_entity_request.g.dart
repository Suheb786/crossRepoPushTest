// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_prepaid_biller_entity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewPrepaidBillerEntityRequest _$AddNewPrepaidBillerEntityRequestFromJson(
    Map<String, dynamic> json) {
  return AddNewPrepaidBillerEntityRequest(
    prepaidCategoryType: json['prepaidCategoryType'] as String?,
    prepaidCategoryCode: json['prepaidCategoryCode'] as String?,
    serviceType: json['serviceType'] as String?,
    serviceCode: json['serviceCode'] as String?,
    billerCode: json['billerCode'] as String?,
    billerName: json['billerName'] as String?,
    billingNumber: json['billingNumber'] as String?,
    nickname: json['nickname'] as String?,
    amount: json['amount'] as String?,
    billingNumberRequired: json['billingNumberRequired'] as bool?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AddNewPrepaidBillerEntityRequestToJson(
        AddNewPrepaidBillerEntityRequest instance) =>
    <String, dynamic>{
      'prepaidCategoryType': instance.prepaidCategoryType,
      'prepaidCategoryCode': instance.prepaidCategoryCode,
      'serviceType': instance.serviceType,
      'serviceCode': instance.serviceCode,
      'billerCode': instance.billerCode,
      'billerName': instance.billerName,
      'billingNumber': instance.billingNumber,
      'nickname': instance.nickname,
      'amount': instance.amount,
      'billingNumberRequired': instance.billingNumberRequired,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
