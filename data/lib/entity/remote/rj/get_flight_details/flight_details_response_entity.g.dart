// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightDetailsResponseEntity _$FlightDetailsResponseEntityFromJson(
        Map<String, dynamic> json) =>
    FlightDetailsResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlightDetailsResponseEntityToJson(
        FlightDetailsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
