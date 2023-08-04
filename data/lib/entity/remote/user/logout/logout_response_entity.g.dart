// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponseEntity _$LogoutResponseEntityFromJson(
        Map<String, dynamic> json) =>
    LogoutResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LogoutResponseEntityToJson(
        LogoutResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
