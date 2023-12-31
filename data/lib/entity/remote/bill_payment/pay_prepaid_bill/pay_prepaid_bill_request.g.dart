// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_prepaid_bill_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPrePaidRequest _$PayPrePaidRequestFromJson(Map<String, dynamic> json) =>
    PayPrePaidRequest(
      billerCode: json['billerCode'] as String?,
      billerName: json['billerName'] as String?,
      billingNumber: json['billingNumber'] as String?,
      serviceType: json['serviceType'] as String?,
      amount: json['amount'] as String?,
      fees: json['fees'] as String?,
      currencyCode: json['currencyCode'] as String?,
      accountNo: json['accountNo'] as String?,
      isNewBiller: json['isNewBiller'] as bool?,
      otpCode: json['otpCode'] as String?,
      validationCode: json['validationCode'] as String?,
      CardId: json['CardId'] as String?,
      nickName: json['NickName'] as String?,
      prepaidCategoryCode: json['prepaidCategoryCode'] as String?,
      prepaidCategoryType: json['prepaidCategoryType'] as String?,
      billingNumberRequired: json['billingNumberRequired'] as bool?,
      isCreditCardPayment: json['isCreditCardPayment'] as bool?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PayPrePaidRequestToJson(PayPrePaidRequest instance) =>
    <String, dynamic>{
      'billerCode': instance.billerCode,
      'billerName': instance.billerName,
      'billingNumber': instance.billingNumber,
      'serviceType': instance.serviceType,
      'amount': instance.amount,
      'fees': instance.fees,
      'currencyCode': instance.currencyCode,
      'accountNo': instance.accountNo,
      'isNewBiller': instance.isNewBiller,
      'otpCode': instance.otpCode,
      'validationCode': instance.validationCode,
      'prepaidCategoryCode': instance.prepaidCategoryCode,
      'prepaidCategoryType': instance.prepaidCategoryType,
      'billingNumberRequired': instance.billingNumberRequired,
      'isCreditCardPayment': instance.isCreditCardPayment,
      'CardId': instance.CardId,
      'NickName': instance.nickName,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
