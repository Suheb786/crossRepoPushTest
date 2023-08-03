// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_values_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanValuesRequestEntity _$GetLoanValuesRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetLoanValuesRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      accountId: json['AccountId'] as String? ?? "1",
    );

Map<String, dynamic> _$GetLoanValuesRequestEntityToJson(
        GetLoanValuesRequestEntity instance) =>
    <String, dynamic>{
      'AccountId': instance.accountId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
