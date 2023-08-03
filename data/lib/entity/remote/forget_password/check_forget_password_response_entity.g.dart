// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_forget_password_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckForgetPasswordResponseEntity _$CheckForgetPasswordResponseEntityFromJson(Map<String, dynamic> json) =>
    CheckForgetPasswordResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckForgetPasswordResponseEntityToJson(CheckForgetPasswordResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
