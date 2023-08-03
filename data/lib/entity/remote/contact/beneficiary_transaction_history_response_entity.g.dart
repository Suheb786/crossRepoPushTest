// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_transaction_history_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryTransactionHistoryResponseEntity _$BeneficiaryTransactionHistoryResponseEntityFromJson(
        Map<String, dynamic> json) =>
    BeneficiaryTransactionHistoryResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeneficiaryTransactionHistoryResponseEntityToJson(
        BeneficiaryTransactionHistoryResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
