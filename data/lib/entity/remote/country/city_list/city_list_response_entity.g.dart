// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityListResponseEntity _$CityListResponseEntityFromJson(Map<String, dynamic> json) => CityListResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityListResponseEntityToJson(CityListResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
