// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountResponseEntity _$GetAccountResponseEntityFromJson(Map<String, dynamic> json) {
  return GetAccountResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAccountResponseEntityToJson(GetAccountResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };
