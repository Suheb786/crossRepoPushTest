// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_key_pair_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateKeyPairResponseEntity _$GenerateKeyPairResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GenerateKeyPairResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenerateKeyPairResponseEntityToJson(
        GenerateKeyPairResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
