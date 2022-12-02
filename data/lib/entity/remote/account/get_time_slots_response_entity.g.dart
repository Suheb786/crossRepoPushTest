// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_time_slots_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTimeSlotsResponseEntity _$GetTimeSlotsResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetTimeSlotsResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetTimeSlotsResponseEntityToJson(
        GetTimeSlotsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
