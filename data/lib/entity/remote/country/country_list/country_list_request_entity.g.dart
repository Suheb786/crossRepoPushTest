// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListRequestEntity _$CountryListRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CountryListRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
    );

Map<String, dynamic> _$CountryListRequestEntityToJson(
        CountryListRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
