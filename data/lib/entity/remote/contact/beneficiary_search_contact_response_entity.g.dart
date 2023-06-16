// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_search_contact_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiarySearchContactResponseEntity _$BeneficiarySearchContactResponseEntityFromJson(
        Map<String, dynamic> json) =>
    BeneficiarySearchContactResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeneficiarySearchContactResponseEntityToJson(
        BeneficiarySearchContactResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
