// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_document_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDocumentRequestEntity _$UploadDocumentRequestEntityFromJson(Map<String, dynamic> json) =>
    UploadDocumentRequestEntity(
      documentBase64: json['DocumentBase64'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UploadDocumentRequestEntityToJson(UploadDocumentRequestEntity instance) =>
    <String, dynamic>{
      'DocumentBase64': instance.documentBase64,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
