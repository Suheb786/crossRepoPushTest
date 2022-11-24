// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_loan_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessLoanResponseEntity _$ProcessLoanResponseEntityFromJson(Map<String, dynamic> json) {
  return ProcessLoanResponseEntity(
    response:
        json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProcessLoanResponseEntityToJson(ProcessLoanResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
