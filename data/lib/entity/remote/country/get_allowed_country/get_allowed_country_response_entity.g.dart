// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allowed_country_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllowedCountryResponseEntity _$GetAllowedCountryResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetAllowedCountryResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAllowedCountryResponseEntityToJson(
    GetAllowedCountryResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
