// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_profile_status_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveProfileStatusResponseEntity _$SaveProfileStatusResponseEntityFromJson(
    Map<String, dynamic> json) {
  return SaveProfileStatusResponseEntity(
    saveProfileStatusResponseDataEntity: json['response'] == null
        ? null
        : SaveProfileStatusResponseDataEntity.fromJson(
            json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaveProfileStatusResponseEntityToJson(
        SaveProfileStatusResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.saveProfileStatusResponseDataEntity,
    };
