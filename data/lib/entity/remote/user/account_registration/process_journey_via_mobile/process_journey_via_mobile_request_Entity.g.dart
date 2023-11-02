// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_journey_via_mobile_request_Entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessJourneyViaMobileRequestEntity
    _$ProcessJourneyViaMobileRequestEntityFromJson(Map<String, dynamic> json) =>
        ProcessJourneyViaMobileRequestEntity(
          JourneyId: json['journeyId'] as String? ?? '',
          ReferenceID: json['ReferenceId'] as String? ?? '',
          getToken: json['GetToken'] as bool?,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$ProcessJourneyViaMobileRequestEntityToJson(
        ProcessJourneyViaMobileRequestEntity instance) =>
    <String, dynamic>{
      'journeyId': instance.JourneyId,
      'ReferenceId': instance.ReferenceID,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
