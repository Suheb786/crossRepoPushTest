// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_document_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDocumentResponseEntity _$UploadDocumentResponseEntityFromJson(
        Map<String, dynamic> json) =>
    UploadDocumentResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadDocumentResponseEntityToJson(
        UploadDocumentResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
