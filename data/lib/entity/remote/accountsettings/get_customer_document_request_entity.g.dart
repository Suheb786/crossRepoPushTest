// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_document_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerDocumentRequestEntity _$GetCustomerDocumentRequestEntityFromJson(Map<String, dynamic> json) =>
    GetCustomerDocumentRequestEntity(
      docId: json['DocId'] as String? ?? "",
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetCustomerDocumentRequestEntityToJson(GetCustomerDocumentRequestEntity instance) =>
    <String, dynamic>{
      'DocId': instance.docId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
