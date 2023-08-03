// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_call_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCallStatusResponseEntity _$VideoCallStatusResponseEntityFromJson(Map<String, dynamic> json) =>
    VideoCallStatusResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoCallStatusResponseEntityToJson(VideoCallStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
