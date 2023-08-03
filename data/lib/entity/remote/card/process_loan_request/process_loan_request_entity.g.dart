// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_loan_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessLoanRequestEntity _$ProcessLoanRequestEntityFromJson(Map<String, dynamic> json) =>
    ProcessLoanRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      cardId: json['cardId'] as String? ?? "",
      loanValueId: json['loanValueid'] as num? ?? 0,
    );

Map<String, dynamic> _$ProcessLoanRequestEntityToJson(ProcessLoanRequestEntity instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'loanValueid': instance.loanValueId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
