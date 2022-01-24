// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_values_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanValuesResponseEntity _$GetLoanValuesResponseEntityFromJson(
    Map<String, dynamic> json) {
  return GetLoanValuesResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetLoanValuesResponseEntityToJson(
        GetLoanValuesResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
