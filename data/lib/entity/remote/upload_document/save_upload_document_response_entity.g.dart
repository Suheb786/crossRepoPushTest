// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_upload_document_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveUploadDocumentResponseEntity _$SaveUploadDocumentResponseEntityFromJson(
    Map<String, dynamic> json) {
  return SaveUploadDocumentResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaveUploadDocumentResponseEntityToJson(
    SaveUploadDocumentResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
