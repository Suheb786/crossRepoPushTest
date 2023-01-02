// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_customer_id_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByCustomerIdResponseEntity _$GetAccountByCustomerIdResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetAccountByCustomerIdResponseEntity(
    json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetAccountByCustomerIdResponseEntityToJson(
        GetAccountByCustomerIdResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
