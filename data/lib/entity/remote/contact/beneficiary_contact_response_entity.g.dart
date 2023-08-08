// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_contact_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryContactResponseEntity _$BeneficiaryContactResponseEntityFromJson(
        Map<String, dynamic> json) =>
    BeneficiaryContactResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeneficiaryContactResponseEntityToJson(
        BeneficiaryContactResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
