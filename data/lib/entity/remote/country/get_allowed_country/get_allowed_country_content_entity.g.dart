// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allowed_country_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllowedCountryContentEntity _$GetAllowedCountryContentEntityFromJson(Map<String, dynamic> json) =>
    GetAllowedCountryContentEntity(
      data: (json['countries'] as List<dynamic>?)
          ?.map((e) => CountryDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllowedCountryContentEntityToJson(GetAllowedCountryContentEntity instance) =>
    <String, dynamic>{
      'countries': instance.data,
    };
