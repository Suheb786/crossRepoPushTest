// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseEntity _$ErrorResponseEntityFromJson(Map<String, dynamic> json) {
  return ErrorResponseEntity(
    json['message'] as String,
    json['code'] as String,
    json['error'] as String,
    json['error_description'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseEntityToJson(
        ErrorResponseEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
