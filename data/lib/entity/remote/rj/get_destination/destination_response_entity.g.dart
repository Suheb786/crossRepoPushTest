// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationResponseEntity _$DestinationResponseEntityFromJson(Map<String, dynamic> json) =>
    DestinationResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DestinationResponseEntityToJson(DestinationResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
