// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejection_reason_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectionReasonRequestEntity _$RejectionReasonRequestEntityFromJson(Map<String, dynamic> json) =>
    RejectionReasonRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RejectionReasonRequestEntityToJson(RejectionReasonRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
