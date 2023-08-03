// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_changed_success_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileChangedSuccessResponseEntity _$ProfileChangedSuccessResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ProfileChangedSuccessResponseEntity(
      responseEntity:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileChangedSuccessResponseEntityToJson(
        ProfileChangedSuccessResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
