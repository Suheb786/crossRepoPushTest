// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_journey_via_mobile_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessJourneViaMobileResponseEntity
    _$ProcessJourneViaMobileResponseEntityFromJson(Map<String, dynamic> json) =>
        ProcessJourneViaMobileResponseEntity(
          json['response'] == null
              ? null
              : ResponseEntity.fromJson(
                  json['response'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ProcessJourneViaMobileResponseEntityToJson(
        ProcessJourneViaMobileResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
