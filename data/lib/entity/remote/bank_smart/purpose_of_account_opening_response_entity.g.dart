// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purpose_of_account_opening_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeOfAccountOpeningResponseEntity
    _$PurposeOfAccountOpeningResponseEntityFromJson(Map<String, dynamic> json) {
  return PurposeOfAccountOpeningResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PurposeOfAccountOpeningResponseEntityToJson(
        PurposeOfAccountOpeningResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
