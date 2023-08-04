// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_years_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitYearsResponseEntity _$DebitYearsResponseEntityFromJson(
        Map<String, dynamic> json) =>
    DebitYearsResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DebitYearsResponseEntityToJson(
        DebitYearsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
