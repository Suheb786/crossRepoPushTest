// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_doc_id_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerDocIdContentEntity _$GetCustomerDocIdContentEntityFromJson(
    Map<String, dynamic> json) {
  return GetCustomerDocIdContentEntity(
    proofOfAddress: json['proofOfAddress'] as String?,
    proofOfIncome: json['proofOfIncome'] as String?,
  );
}

Map<String, dynamic> _$GetCustomerDocIdContentEntityToJson(
        GetCustomerDocIdContentEntity instance) =>
    <String, dynamic>{
      'proofOfIncome': instance.proofOfIncome,
      'proofOfAddress': instance.proofOfAddress,
    };
