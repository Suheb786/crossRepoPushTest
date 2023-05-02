// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_application_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardApplicationResponseEntity _$GetCardApplicationResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GetCardApplicationResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCardApplicationResponseEntityToJson(
        GetCardApplicationResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
