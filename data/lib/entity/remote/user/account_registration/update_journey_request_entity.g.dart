// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_journey_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateJourneyRequestEntity _$UpdateJourneyRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UpdateJourneyRequestEntity(
      userID: json['UserID'] as String?,
      refID: json['RefID'] as String?,
      journeyID: json['JourneyID'] as String?,
      status: json['Status'] as String?,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateJourneyRequestEntityToJson(
        UpdateJourneyRequestEntity instance) =>
    <String, dynamic>{
      'UserID': instance.userID,
      'RefID': instance.refID,
      'JourneyID': instance.journeyID,
      'Status': instance.status,
      'BaseClass': instance.baseClass,
    };
