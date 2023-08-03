// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListResponseEntity _$CountryListResponseEntityFromJson(Map<String, dynamic> json) =>
    CountryListResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryListResponseEntityToJson(CountryListResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
