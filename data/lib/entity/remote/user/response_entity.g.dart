// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEntity _$ResponseEntityFromJson(Map<String, dynamic> json) {
  return ResponseEntity(
    code: json['code'] as int?,
    content: json['content'],
    exceptionMessage: json['exceptionMessage'] as String?,
    message: json['message'] as String?,
    token: json['token'] as String?,
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$ResponseEntityToJson(ResponseEntity instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
    };
