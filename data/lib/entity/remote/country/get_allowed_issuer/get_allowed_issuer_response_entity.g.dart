// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allowed_issuer_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllowedIssuerResponseEntity _$GetAllowedIssuerResponseEntityFromJson(Map<String, dynamic> json) =>
    GetAllowedIssuerResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllowedIssuerResponseEntityToJson(GetAllowedIssuerResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
