// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightDetailsEntity _$FlightDetailsEntityFromJson(Map<String, dynamic> json) {
  return FlightDetailsEntity(
    flightNumber: json['FlightNumber'] as String?,
    origin: json['Origin'] as String?,
    destination: json['Destination'] as String?,
    flightDate: json['FlightDate'] as String?,
  );
}

Map<String, dynamic> _$FlightDetailsEntityToJson(FlightDetailsEntity instance) => <String, dynamic>{
      'FlightNumber': instance.flightNumber,
      'Origin': instance.origin,
      'Destination': instance.destination,
      'FlightDate': instance.flightDate,
    };
