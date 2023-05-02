// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordResponseEntity _$ForgetPasswordResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForgetPasswordResponseEntityToJson(
        ForgetPasswordResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
