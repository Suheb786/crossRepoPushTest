// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trip_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripResponseEntity _$GetTripResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GetTripResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTripResponseEntityToJson(
        GetTripResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
