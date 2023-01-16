// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_biller_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateBillerOtpRequest _$ValidateBillerOtpRequestFromJson(Map<String, dynamic> json) {
  return ValidateBillerOtpRequest(
    billerType: json['BillerType'] as String?,
    amount: json['Amount'] as String?,
    currencyCode: json['CurrencyCode'] as String?,
    accountNo: json['AccountNo'] as String?,
    isNewBiller: json['IsNewBiller'] as bool?,
    getToken: json['getToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ValidateBillerOtpRequestToJson(ValidateBillerOtpRequest instance) => <String, dynamic>{
      'BillerType': instance.billerType,
      'Amount': instance.amount,
      'CurrencyCode': instance.currencyCode,
      'AccountNo': instance.accountNo,
      'IsNewBiller': instance.isNewBiller,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
