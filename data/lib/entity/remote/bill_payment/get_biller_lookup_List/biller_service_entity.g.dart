// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller_service_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillerServiceEntity _$BillerServiceEntityFromJson(Map<String, dynamic> json) {
  return BillerServiceEntity(
    serviceType: json['serviceType'] as String?,
    serviceCode: json['serviceCode'] as String?,
    paymentType: json['paymentType'] as String?,
    serviceDescriptionAr: json['serviceDescriptionAr'] as String?,
    serviceDescriptionEn: json['serviceDescriptionEn'] as String?,
    billingNoRequired: json['billingNoRequired'] as bool?,
    containPrepaidCat: json['containPrepaidCat'] as bool?,
    fieldDescriptionAr: json['fieldDescriptionAr'] as String?,
    fieldDescriptionEn: json['fieldDescriptionEn'] as String?,
    fieldLabelAr: json['fieldLabelAr'] as String?,
    fieldLabelEn: json['fieldLabelEn'] as String?,
    prepaidCategories: (json['prepaidCategories'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$BillerServiceEntityToJson(
        BillerServiceEntity instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'serviceCode': instance.serviceCode,
      'paymentType': instance.paymentType,
      'serviceDescriptionAr': instance.serviceDescriptionAr,
      'serviceDescriptionEn': instance.serviceDescriptionEn,
      'billingNoRequired': instance.billingNoRequired,
      'containPrepaidCat': instance.containPrepaidCat,
      'fieldDescriptionAr': instance.fieldDescriptionAr,
      'fieldDescriptionEn': instance.fieldDescriptionEn,
      'fieldLabelAr': instance.fieldLabelAr,
      'fieldLabelEn': instance.fieldLabelEn,
      'prepaidCategories': instance.prepaidCategories,
    };
