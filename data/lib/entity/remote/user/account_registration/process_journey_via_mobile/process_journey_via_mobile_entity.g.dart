// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_journey_via_mobile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessJourneyViaMobileEntity _$ProcessJourneyViaMobileEntityFromJson(
        Map<String, dynamic> json) =>
    ProcessJourneyViaMobileEntity(
      reason: json['reason'] as String?,
      isAllowPooling: json['isAllowPooling'] as bool?,
      idWiseError: json['idWiseError'] as String?,
      journeyInProcess: json['JourneyInProcess'] as bool?,
    );

Map<String, dynamic> _$ProcessJourneyViaMobileEntityToJson(
        ProcessJourneyViaMobileEntity instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'isAllowPooling': instance.isAllowPooling,
      'idWiseError': instance.idWiseError,
      'JourneyInProcess': instance.journeyInProcess,
    };
