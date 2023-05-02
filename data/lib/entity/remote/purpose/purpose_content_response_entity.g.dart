// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_content_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeContentResponseEntity _$PurposeContentResponseEntityFromJson(
        Map<String, dynamic> json) =>
    PurposeContentResponseEntity(
      purposeContentEntity: json['content'] == null
          ? null
          : PurposeContentEntity.fromJson(
              json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurposeContentResponseEntityToJson(
        PurposeContentResponseEntity instance) =>
    <String, dynamic>{
      'content': instance.purposeContentEntity,
    };
