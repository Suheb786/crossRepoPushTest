// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountDetailsResponseEntity _$GetAccountDetailsResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetAccountDetailsResponseEntity(
    responseEntity: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAccountDetailsResponseEntityToJson(
    GetAccountDetailsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
