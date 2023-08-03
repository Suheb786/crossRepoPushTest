// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_call_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCallEntity _$RequestCallEntityFromJson(Map<String, dynamic> json) =>
    RequestCallEntity(
      conferenceLink: json['conferenceLink'] as String? ?? "",
      callId: json['callId'] as String? ?? "",
    );

Map<String, dynamic> _$RequestCallEntityToJson(RequestCallEntity instance) =>
    <String, dynamic>{
      'conferenceLink': instance.conferenceLink,
      'callId': instance.callId,
    };
