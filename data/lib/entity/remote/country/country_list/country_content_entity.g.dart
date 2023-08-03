// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryContentEntity _$CountryContentEntityFromJson(
        Map<String, dynamic> json) =>
    CountryContentEntity(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountryDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryContentEntityToJson(
        CountryContentEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
