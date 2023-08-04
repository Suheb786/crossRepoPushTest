// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationEntity _$DestinationEntityFromJson(Map<String, dynamic> json) =>
    DestinationEntity(
      name: json['name'] as String?,
      code: json['code'] as String?,
      countryName: json['countryName'] as String?,
      cityName: json['cityName'] as String?,
      airportName: json['airportName'] as String?,
    );

Map<String, dynamic> _$DestinationEntityToJson(DestinationEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'countryName': instance.countryName,
      'cityName': instance.cityName,
      'airportName': instance.airportName,
    };
