// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_prepaid_categories_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrePaidCategoriesRequestEntity _$GetPrePaidCategoriesRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetPrePaidCategoriesRequestEntity(
    billerCode: json['billerCode'] as String?,
    serviceCode: json['serviceCode'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetPrePaidCategoriesRequestEntityToJson(
        GetPrePaidCategoriesRequestEntity instance) =>
    <String, dynamic>{
      'billerCode': instance.billerCode,
      'serviceCode': instance.serviceCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
