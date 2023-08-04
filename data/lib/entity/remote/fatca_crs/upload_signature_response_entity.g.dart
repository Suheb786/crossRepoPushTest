// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_signature_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadSignatureResponseEntity _$UploadSignatureResponseEntityFromJson(
        Map<String, dynamic> json) =>
    UploadSignatureResponseEntity(
      responseEntity: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadSignatureResponseEntityToJson(
        UploadSignatureResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
