// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateListResponseEntity _$StateListResponseEntityFromJson(Map<String, dynamic> json) =>
    StateListResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StateListResponseEntityToJson(StateListResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
