// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEntity _$ErrorEntityFromJson(Map<String, dynamic> json) => ErrorEntity(
      code: json['Code'] as String?,
      titleAr: json['TitleAr'] as String?,
      titleEn: json['TitleEn'] as String?,
      messageAr: json['MessageAr'] as String?,
      messageEn: json['MessageEn'] as String?,
    );

Map<String, dynamic> _$ErrorEntityToJson(ErrorEntity instance) =>
    <String, dynamic>{
      'TitleAr': instance.titleAr,
      'TitleEn': instance.titleEn,
      'MessageEn': instance.messageEn,
      'MessageAr': instance.messageAr,
      'Code': instance.code,
    };
