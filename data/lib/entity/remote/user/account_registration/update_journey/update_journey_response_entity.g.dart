// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_journey_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateJourneyResponseEntity _$UpdateJourneyResponseEntityFromJson(
        Map<String, dynamic> json) =>
    UpdateJourneyResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateJourneyResponseEntityToJson(
        UpdateJourneyResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
