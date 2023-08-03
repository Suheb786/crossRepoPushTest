// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_profile_status_response_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveProfileStatusResponseDataEntity _$SaveProfileStatusResponseDataEntityFromJson(
        Map<String, dynamic> json) =>
    SaveProfileStatusResponseDataEntity(
      code: json['code'] as int?,
      content: json['content'] as String?,
      exceptionMessage: json['exceptionMessage'],
      message: json['message'] as String?,
      token: json['token'] as String?,
      id: json['id'],
    );

Map<String, dynamic> _$SaveProfileStatusResponseDataEntityToJson(
        SaveProfileStatusResponseDataEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
    };
