// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejection_reason_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectionReasonResponseEntity _$RejectionReasonResponseEntityFromJson(Map<String, dynamic> json) {
  return RejectionReasonResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RejectionReasonResponseEntityToJson(RejectionReasonResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
