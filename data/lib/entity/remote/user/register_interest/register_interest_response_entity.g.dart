// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_interest_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInterestResponseEntity _$RegisterInterestResponseEntityFromJson(Map<String, dynamic> json) =>
    RegisterInterestResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterInterestResponseEntityToJson(RegisterInterestResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
