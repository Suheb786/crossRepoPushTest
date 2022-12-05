// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightDetailsEntity _$FlightDetailsEntityFromJson(Map<String, dynamic> json) {
  return FlightDetailsEntity(
    flightNumber: json['flightNumber'] as String?,
    origin: json['origin'] as String?,
    destination: json['destination'] as String?,
    flightDate: json['flightDate'] as String?,
  );
}

Map<String, dynamic> _$FlightDetailsEntityToJson(FlightDetailsEntity instance) => <String, dynamic>{
      'flightNumber': instance.flightNumber,
      'origin': instance.origin,
      'destination': instance.destination,
      'flightDate': instance.flightDate,
    };
