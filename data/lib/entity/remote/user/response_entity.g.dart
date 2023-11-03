// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEntity _$ResponseEntityFromJson(Map<String, dynamic> json) =>
    ResponseEntity(
      code: json['code'] as int?,
      content: json['content'],
      exceptionMessage: json['exceptionMessage'] as String?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      id: json['id'] as String?,
      error: json['error'] == null
          ? null
          : ErrorEntity.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseEntityToJson(ResponseEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
      'error': instance.error,
    };
