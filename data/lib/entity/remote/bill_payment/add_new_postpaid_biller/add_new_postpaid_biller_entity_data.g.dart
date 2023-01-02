// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_postpaid_biller_entity_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewPostpaidBillerEntityData _$AddNewPostpaidBillerEntityDataFromJson(
    Map<String, dynamic> json) {
  return AddNewPostpaidBillerEntityData(
    joebppsNo: json['joebppsNo'] as String?,
    billerCode: json['billerCode'] as String?,
    billingNo: json['billingNo'] as String?,
    serviceType: json['serviceType'] as String?,
    nickName: json['nickName'] as String?,
  );
}

Map<String, dynamic> _$AddNewPostpaidBillerEntityDataToJson(
        AddNewPostpaidBillerEntityData instance) =>
    <String, dynamic>{
      'joebppsNo': instance.joebppsNo,
      'billerCode': instance.billerCode,
      'billingNo': instance.billingNo,
      'serviceType': instance.serviceType,
      'nickName': instance.nickName,
    };
