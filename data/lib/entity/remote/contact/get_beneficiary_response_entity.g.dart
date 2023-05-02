// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_beneficiary_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBeneficiaryResponseEntity _$GetBeneficiaryResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GetBeneficiaryResponseEntity(
      responseEntity: json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBeneficiaryResponseEntityToJson(
        GetBeneficiaryResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.responseEntity,
    };
