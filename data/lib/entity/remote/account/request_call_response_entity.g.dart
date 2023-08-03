// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_call_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCallResponseEntity _$RequestCallResponseEntityFromJson(
        Map<String, dynamic> json) =>
    RequestCallResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestCallResponseEntityToJson(
        RequestCallResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
