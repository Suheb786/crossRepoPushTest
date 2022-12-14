// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_prepaid_biller_list_entity_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrepaidBillerListEntityData _$GetPrepaidBillerListEntityDataFromJson(
    Map<String, dynamic> json) {
  return GetPrepaidBillerListEntityData(
    billingNumber: json['billingNo'] as String?,
    billerCode: json['billerCode'] as String?,
    billerName: json['billerName'] as String?,
    nickname: json['nickName'] as String?,
    registrationId: json['registrationID'] as String?,
    prepaidCategoryDescription: json['prepaidCategoryDescription'] as String?,
    prepaidCategoryCode: json['prepaidCategoryCode'] as String?,
    customerType: json['customerType'] as String?,
    joebppsNo: json['joebppsNo'] as String?,
    serviceType: json['serviceType'] as String?,
    serviceCode: json['serviceCode'] as String?,
    iconCode: json['iconCode'],
    rimNo: json['rimNo'] as String?,
  );
}

Map<String, dynamic> _$GetPrepaidBillerListEntityDataToJson(
        GetPrepaidBillerListEntityData instance) =>
    <String, dynamic>{
      'billingNo': instance.billingNumber,
      'billerCode': instance.billerCode,
      'billerName': instance.billerName,
      'nickName': instance.nickname,
      'registrationID': instance.registrationId,
      'prepaidCategoryDescription': instance.prepaidCategoryDescription,
      'prepaidCategoryCode': instance.prepaidCategoryCode,
      'customerType': instance.customerType,
      'joebppsNo': instance.joebppsNo,
      'serviceType': instance.serviceType,
      'serviceCode': instance.serviceCode,
      'iconCode': instance.iconCode,
      'rimNo': instance.rimNo,
    };
