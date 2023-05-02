// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_country_residence_info_response_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCountryResidenceInfoResponseDataEntity
    _$SaveCountryResidenceInfoResponseDataEntityFromJson(
            Map<String, dynamic> json) =>
        SaveCountryResidenceInfoResponseDataEntity(
          code: json['code'] as int?,
          content: json['content'] as String?,
          exceptionMessage: json['exceptionMessage'],
          message: json['message'] as String?,
          token: json['token'] as String?,
          id: json['id'],
        );

Map<String, dynamic> _$SaveCountryResidenceInfoResponseDataEntityToJson(
        SaveCountryResidenceInfoResponseDataEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
    };
