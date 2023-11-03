// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_journey_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckJourneyStatusResponseEntity _$CheckJourneyStatusResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CheckJourneyStatusResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckJourneyStatusResponseEntityToJson(
        CheckJourneyStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
