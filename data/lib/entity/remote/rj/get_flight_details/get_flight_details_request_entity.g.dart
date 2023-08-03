// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_flight_details_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFlightDetailsRequestEntity _$GetFlightDetailsRequestEntityFromJson(Map<String, dynamic> json) =>
    GetFlightDetailsRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      referenceNumber: json['ReferenceNumber'] as String?,
    );

Map<String, dynamic> _$GetFlightDetailsRequestEntityToJson(GetFlightDetailsRequestEntity instance) =>
    <String, dynamic>{
      'ReferenceNumber': instance.referenceNumber,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
