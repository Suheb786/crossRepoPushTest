// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_reason_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejctReasonListEntity _$RejctReasonListResponseEntityFromJson(Map<String, dynamic> json) {
  return RejctReasonListEntity(
    code: json['code'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$RejctReasonListResponseEntityToJson(RejctReasonListEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
    };
