// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_agent_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAgentStatusResponseEntity _$CheckAgentStatusResponseEntityFromJson(Map<String, dynamic> json) {
  return CheckAgentStatusResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckAgentStatusResponseEntityToJson(CheckAgentStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
