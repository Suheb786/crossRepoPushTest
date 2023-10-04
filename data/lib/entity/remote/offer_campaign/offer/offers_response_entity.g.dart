// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersResponseEntity _$OffersResponseEntityFromJson(
        Map<String, dynamic> json) =>
    OffersResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersResponseEntityToJson(
        OffersResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
