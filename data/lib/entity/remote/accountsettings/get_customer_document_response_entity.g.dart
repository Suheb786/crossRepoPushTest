// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_document_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerDocumentResponseEntity _$GetCustomerDocumentResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetCustomerDocumentResponseEntity(
    responseEntity: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetCustomerDocumentResponseEntityToJson(
        GetCustomerDocumentResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
