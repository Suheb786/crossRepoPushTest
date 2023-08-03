// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allowed_issuer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllowedIssuerEntity _$GetAllowedIssuerEntityFromJson(
        Map<String, dynamic> json) =>
    GetAllowedIssuerEntity(
      countryISOCode3: json['countryISOCode3'] as String?,
      regex: json['regex'] as String?,
    );

Map<String, dynamic> _$GetAllowedIssuerEntityToJson(
        GetAllowedIssuerEntity instance) =>
    <String, dynamic>{
      'countryISOCode3': instance.countryISOCode3,
      'regex': instance.regex,
    };
