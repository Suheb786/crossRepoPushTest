// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillerDetailsEntity _$BillerDetailsEntityFromJson(Map<String, dynamic> json) => BillerDetailsEntity(
      billerCode: json['billerCode'],
      billerNameEn: json['billerNameEn'] as String?,
      billerNameAr: json['billerNameAr'] as String?,
      billerServices:
          (json['billerServices'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
    );

Map<String, dynamic> _$BillerDetailsEntityToJson(BillerDetailsEntity instance) => <String, dynamic>{
      'billerCode': instance.billerCode,
      'billerNameEn': instance.billerNameEn,
      'billerNameAr': instance.billerNameAr,
      'billerServices': instance.billerServices,
    };
