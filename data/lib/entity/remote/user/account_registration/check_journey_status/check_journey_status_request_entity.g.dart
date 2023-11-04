// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_journey_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckJourneyStatusRequestEntity _$CheckJourneyStatusRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CheckJourneyStatusRequestEntity(
      referenceId: json['ReferenceId'] as String?,
      journeyId: json['journeyId'] as String?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool?,
    );

Map<String, dynamic> _$CheckJourneyStatusRequestEntityToJson(
        CheckJourneyStatusRequestEntity instance) =>
    <String, dynamic>{
      'ReferenceId': instance.referenceId,
      'journeyId': instance.journeyId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
