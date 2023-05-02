// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atms_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtmsEntity _$AtmsEntityFromJson(Map<String, dynamic> json) => AtmsEntity(
      bankName: json['bankName'] as String?,
      bankAddress: json['bankAddress'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$AtmsEntityToJson(AtmsEntity instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'bankAddress': instance.bankAddress,
      'country': instance.country,
      'city': instance.city,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
