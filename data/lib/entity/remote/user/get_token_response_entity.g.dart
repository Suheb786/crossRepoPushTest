// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_token_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenResponseEntity _$GetTokenResponseEntityFromJson(Map<String, dynamic> json) => GetTokenResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTokenResponseEntityToJson(GetTokenResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
