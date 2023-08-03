// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateCityDataEntity _$StateCityDataEntityFromJson(Map<String, dynamic> json) => StateCityDataEntity(
      createTime: json['createTime'] == null ? null : DateTime.parse(json['createTime'] as String),
      countryID: json['countryID'] as String? ?? "",
      stateID: json['stateID'] as String? ?? "",
      stateName: json['stateName'] as String? ?? "",
      cityName: json['name'] as String? ?? "",
      cityID: json['cityID'] as String? ?? "",
      cityNameAR: json['nameAR'] as String? ?? "",
      stateNameAR: json['stateNameAR'] as String? ?? "",
    );

Map<String, dynamic> _$StateCityDataEntityToJson(StateCityDataEntity instance) => <String, dynamic>{
      'createTime': instance.createTime?.toIso8601String(),
      'countryID': instance.countryID,
      'stateID': instance.stateID,
      'stateName': instance.stateName,
      'stateNameAR': instance.stateNameAR,
      'cityID': instance.cityID,
      'name': instance.cityName,
      'nameAR': instance.cityNameAR,
    };
