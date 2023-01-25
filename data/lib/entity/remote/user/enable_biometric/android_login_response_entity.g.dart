// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_login_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndroidLoginResponseEntity _$AndroidLoginResponseEntityFromJson(Map<String, dynamic> json) {
  return AndroidLoginResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AndroidLoginResponseEntityToJson(AndroidLoginResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
