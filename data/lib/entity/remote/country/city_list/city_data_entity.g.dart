// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDataEntity _$CityDataEntityFromJson(Map<String, dynamic> json) =>
    CityDataEntity(
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      countryID: json['countryID'] as String? ?? "",
      stateID: json['stateID'] as String? ?? "",
      cityName: json['name'] as String? ?? "",
      cityID: json['cityID'] as String? ?? "",
    );

Map<String, dynamic> _$CityDataEntityToJson(CityDataEntity instance) =>
    <String, dynamic>{
      'createTime': instance.createTime?.toIso8601String(),
      'countryID': instance.countryID,
      'stateID': instance.stateID,
      'cityID': instance.cityID,
      'name': instance.cityName,
    };
