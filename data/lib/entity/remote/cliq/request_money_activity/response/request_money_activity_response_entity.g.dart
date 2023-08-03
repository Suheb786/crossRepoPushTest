// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_activity_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyActivityResponseEntity _$RequestMoneyActivityResponseEntityFromJson(Map<String, dynamic> json) =>
    RequestMoneyActivityResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestMoneyActivityResponseEntityToJson(
        RequestMoneyActivityResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
