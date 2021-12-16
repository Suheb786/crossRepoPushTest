// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_name_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserNameResponseEntity _$CheckUserNameResponseEntityFromJson(
    Map<String, dynamic> json) {
  return CheckUserNameResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckUserNameResponseEntityToJson(
        CheckUserNameResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
