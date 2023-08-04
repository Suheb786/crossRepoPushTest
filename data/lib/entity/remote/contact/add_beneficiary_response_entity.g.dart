// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryResponseEntity _$AddBeneficiaryResponseEntityFromJson(
        Map<String, dynamic> json) =>
    AddBeneficiaryResponseEntity(
      response: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddBeneficiaryResponseEntityToJson(
        AddBeneficiaryResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
