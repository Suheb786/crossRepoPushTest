// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_agent_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAgentStatusRequestEntity _$CheckAgentStatusRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CheckAgentStatusRequestEntity(
      getToken: json['GetToken'] as bool?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CheckAgentStatusRequestEntityToJson(
        CheckAgentStatusRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
