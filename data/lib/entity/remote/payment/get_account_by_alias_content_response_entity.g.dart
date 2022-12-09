// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_alias_content_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByAliasContentResponseEntity
    _$GetAccountByAliasContentResponseEntityFromJson(
        Map<String, dynamic> json) {
  return GetAccountByAliasContentResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAccountByAliasContentResponseEntityToJson(
        GetAccountByAliasContentResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
