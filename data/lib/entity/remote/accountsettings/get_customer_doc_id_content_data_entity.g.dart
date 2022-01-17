// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_doc_id_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerDocIdContentDataEntity _$GetCustomerDocIdContentDataEntityFromJson(
    Map<String, dynamic> json) {
  return GetCustomerDocIdContentDataEntity(
    documents: json['documents'] == null
        ? null
        : GetCustomerDocIdContentEntity.fromJson(
            json['documents'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetCustomerDocIdContentDataEntityToJson(
        GetCustomerDocIdContentDataEntity instance) =>
    <String, dynamic>{
      'documents': instance.documents,
    };
