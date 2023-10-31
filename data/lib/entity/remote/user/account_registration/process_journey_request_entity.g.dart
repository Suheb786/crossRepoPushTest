// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_journey_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessJourneyRequestEntity _$ProcessJourneyRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ProcessJourneyRequestEntity(
      refID: json['RefID'] as String?,
      journeyID: json['JourneyID'] as String?,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProcessJourneyRequestEntityToJson(
        ProcessJourneyRequestEntity instance) =>
    <String, dynamic>{
      'RefID': instance.refID,
      'JourneyID': instance.journeyID,
      'BaseClass': instance.baseClass,
    };
