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
    minimumSettlement: json['MinimumSettlement'] as String?,
    loanValueId: json['LoanValueId'] as num?,
    nickName: json['NickName'] as String?,
    creditLimit: json['CreditLimit'] as num?,
  );
}

Map<String, dynamic> _$ProcessLoanRequestEntityToJson(
        ProcessLoanRequestEntity instance) =>
    <String, dynamic>{
      'MinimumSettlement': instance.minimumSettlement,
      'NickName': instance.nickName,
      'LoanValueId': instance.loanValueId,
      'CreditLimit': instance.creditLimit,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
