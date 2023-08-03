// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_postpaid_biller_entity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewPostpaidBillerEntityRequest _$AddNewPostpaidBillerEntityRequestFromJson(
        Map<String, dynamic> json) =>
    AddNewPostpaidBillerEntityRequest(
      serviceType: json['serviceType'] as String?,
      billerCode: json['billerCode'] as String?,
      billingNumber: json['billingNumber'] as String?,
      nickname: json['nickname'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddNewPostpaidBillerEntityRequestToJson(
        AddNewPostpaidBillerEntityRequest instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'billerCode': instance.billerCode,
      'billingNumber': instance.billingNumber,
      'nickname': instance.nickname,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
