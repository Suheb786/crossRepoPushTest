// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_video_call_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestVideoCallRequest _$RequestVideoCallRequestFromJson(
        Map<String, dynamic> json) =>
    RequestVideoCallRequest(
      gender: json['Gender'] as String? ?? "",
      baseData: json['BaseClass'] as Map<String, dynamic>,
      type: json['Type'] as String? ?? "ONBOARD",
    );

Map<String, dynamic> _$RequestVideoCallRequestToJson(
        RequestVideoCallRequest instance) =>
    <String, dynamic>{
      'Gender': instance.gender,
      'Type': instance.type,
      'BaseClass': instance.baseData,
    };
