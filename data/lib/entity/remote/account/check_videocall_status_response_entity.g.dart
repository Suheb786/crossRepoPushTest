// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_videocall_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVideoCallStatusResponseEntity _$CheckVideoCallStatusResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CheckVideoCallStatusResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckVideoCallStatusResponseEntityToJson(
        CheckVideoCallStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
