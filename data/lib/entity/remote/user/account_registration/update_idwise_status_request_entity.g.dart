// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_idwise_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateIDWiseStatusRequestEntity _$UpdateIDWiseStatusRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UpdateIDWiseStatusRequestEntity(
      refID: json['RefID'] as String?,
      journeyID: json['JourneyID'] as String?,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateIDWiseStatusRequestEntityToJson(
        UpdateIDWiseStatusRequestEntity instance) =>
    <String, dynamic>{
      'RefID': instance.refID,
      'JourneyID': instance.journeyID,
      'BaseClass': instance.baseClass,
    };
