// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetailsEntity _$ProfileDetailsEntityFromJson(Map<String, dynamic> json) {
  return ProfileDetailsEntity(
    profileInfo: json['profileInfo'] == null
        ? null
        : ProfileEntity.fromJson(json['profileInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileDetailsEntityToJson(ProfileDetailsEntity instance) => <String, dynamic>{
      'profileInfo': instance.profileInfo,
    };
