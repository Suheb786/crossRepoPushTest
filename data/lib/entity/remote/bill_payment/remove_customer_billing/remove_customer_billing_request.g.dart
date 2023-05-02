// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_customer_billing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveCustomerBillingRequest _$RemoveCustomerBillingRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveCustomerBillingRequest(
      billerCode: json['billerCode'] as String?,
      billingNo: json['billingNo'] as String?,
      serviceType: json['serviceType'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RemoveCustomerBillingRequestToJson(
        RemoveCustomerBillingRequest instance) =>
    <String, dynamic>{
      'billerCode': instance.billerCode,
      'billingNo': instance.billingNo,
      'serviceType': instance.serviceType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
