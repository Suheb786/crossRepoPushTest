// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_loan_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessLoanRequestEntity _$ProcessLoanRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ProcessLoanRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    cardId: json['CardId'] as String?,
    loanValueId: json['LoanValueId'] as num?,
  );
}

Map<String, dynamic> _$ProcessLoanRequestEntityToJson(
        ProcessLoanRequestEntity instance) =>
    <String, dynamic>{
      'CardId': instance.cardId,
      'LoanValueId': instance.loanValueId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
