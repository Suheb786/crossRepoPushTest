// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocStatusResponseEntity _$DocStatusResponseEntityFromJson(Map<String, dynamic> json) =>
    DocStatusResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocStatusResponseEntityToJson(DocStatusResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
