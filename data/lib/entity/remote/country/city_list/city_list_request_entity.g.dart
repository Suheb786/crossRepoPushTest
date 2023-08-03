// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_list_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityListRequestEntity _$CityListRequestEntityFromJson(Map<String, dynamic> json) => CityListRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      isoCode: json['IsoCode'] as String? ?? "",
      stateID: json['StateID'] as String? ?? "",
    );

Map<String, dynamic> _$CityListRequestEntityToJson(CityListRequestEntity instance) => <String, dynamic>{
      'StateID': instance.stateID,
      'IsoCode': instance.isoCode,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
