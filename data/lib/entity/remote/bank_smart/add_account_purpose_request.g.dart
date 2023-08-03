// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_account_purpose_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAccountPurposeRequest _$AddAccountPurposeRequestFromJson(Map<String, dynamic> json) =>
    AddAccountPurposeRequest(
      getToken: json['GetToken'] as bool? ?? true,
      purpose: json['Purpose'] as String? ?? "",
      isCashDeposit: json['IsCashDeposit'] as bool? ?? true,
      isTransfer: json['IsTransfer'] as bool? ?? true,
      isBillPayment: json['IsBillPayment'] as bool? ?? true,
      isOther: json['IsOther'] as bool? ?? true,
      monthlyTransaction: json['MonthlyTransaction'] as num? ?? 0.0,
      annualTransaction: json['AnualTransaction'] as num? ?? 0.0,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddAccountPurposeRequestToJson(AddAccountPurposeRequest instance) => <String, dynamic>{
      'GetToken': instance.getToken,
      'Purpose': instance.purpose,
      'IsCashDeposit': instance.isCashDeposit,
      'IsTransfer': instance.isTransfer,
      'IsBillPayment': instance.isBillPayment,
      'IsOther': instance.isOther,
      'MonthlyTransaction': instance.monthlyTransaction,
      'AnualTransaction': instance.annualTransaction,
      'baseClass': instance.baseData,
    };
