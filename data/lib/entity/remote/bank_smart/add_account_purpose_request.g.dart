// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_account_purpose_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAccountPurposeRequest _$AddAccountPurposeRequestFromJson(
    Map<String, dynamic> json) {
  return AddAccountPurposeRequest(
    getToken: json['GetToken'] as bool?,
    purpose: json['Purpose'] as String?,
    isCashDeposit: json['IsCashDeposit'] as bool?,
    isTransfer: json['IsTransfer'] as bool?,
    isBillPayment: json['IsBillPayment'] as bool?,
    isOther: json['IsOther'] as bool?,
    monthlyTransaction: (json['MonthlyTransaction'] as num?)?.toDouble(),
    annualTransaction: (json['AnualTransaction'] as num?)?.toDouble(),
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddAccountPurposeRequestToJson(
        AddAccountPurposeRequest instance) =>
    <String, dynamic>{
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
