// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_signature_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadSignatureRequestEntity _$UploadSignatureRequestEntityFromJson(
        Map<String, dynamic> json) =>
    UploadSignatureRequestEntity(
      image: json['Image'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UploadSignatureRequestEntityToJson(
        UploadSignatureRequestEntity instance) =>
    <String, dynamic>{
      'Image': instance.image,
      'baseClass': instance.baseData,
    };
