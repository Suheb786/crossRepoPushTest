// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_existing_call_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckExistingCallResponseEntity _$CheckExistingCallResponseEntityFromJson(
    Map<String, dynamic> json) {
  return CheckExistingCallResponseEntity(
    json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckExistingCallResponseEntityToJson(
        CheckExistingCallResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
