// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetailsResponseEntity _$ProfileDetailsResponseEntityFromJson(Map<String, dynamic> json) =>
    ProfileDetailsResponseEntity(
      responseEntity:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileDetailsResponseEntityToJson(ProfileDetailsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
