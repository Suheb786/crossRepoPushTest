// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_signature_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadSignatureResponseEntity _$UploadSignatureResponseEntityFromJson(
    Map<String, dynamic> json) {
  return UploadSignatureResponseEntity(
    code: json['code'] as int?,
    content: json['content'] as String?,
    exceptionMessage: json['exceptionMessage'] as String?,
    message: json['message'] as String?,
    token: json['token'] as String?,
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$UploadSignatureResponseEntityToJson(
    UploadSignatureResponseEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
    };
