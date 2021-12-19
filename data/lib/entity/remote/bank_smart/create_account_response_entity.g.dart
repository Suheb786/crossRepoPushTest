// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountResponseEntity _$CreateAccountResponseEntityFromJson(
    Map<String, dynamic> json) {
  return CreateAccountResponseEntity(
    responseEntity: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateAccountResponseEntityToJson(
    CreateAccountResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
