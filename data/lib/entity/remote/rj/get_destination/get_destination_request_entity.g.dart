// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_destination_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDestinationRequestEntity _$GetDestinationRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetDestinationRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      language: json['Language'] as String?,
      origin: json['Origin'] as String?,
      service: json['Service'] as String?,
    );

Map<String, dynamic> _$GetDestinationRequestEntityToJson(
        GetDestinationRequestEntity instance) =>
    <String, dynamic>{
      'Language': instance.language,
      'Service': instance.service,
      'Origin': instance.origin,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
