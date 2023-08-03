// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_doc_id_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerDocIdResponseEntity _$GetCustomerDocIdResponseEntityFromJson(Map<String, dynamic> json) =>
    GetCustomerDocIdResponseEntity(
      responseEntity:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCustomerDocIdResponseEntityToJson(GetCustomerDocIdResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
