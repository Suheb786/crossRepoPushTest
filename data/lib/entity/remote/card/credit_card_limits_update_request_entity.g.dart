// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_limits_update_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardSLimitsUpdateRequestEntity _$CreditCardSLimitsUpdateRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CreditCardSLimitsUpdateRequestEntity(
    getToken: json['GetToken'] as bool?,
    atmWithdrawal: json['ATMLimit'] as num?,
    merchantsPayments: json['MerchantLimit'] as num?,
    onlinePurchase: json['OnlinePurchaseLimit'] as num?,
    isAtmWithdrawal: json['ATM'] as bool?,
    isMerchantsPayments: json['Merchant'] as bool?,
    isOnlinePurchase: json['OnlinePurchase'] as bool?,
    isContactLessPayments: json['ContactLessPayment'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>?,
    secureCode: json['SecureCode'] as String?,
  );
}

Map<String, dynamic> _$CreditCardSLimitsUpdateRequestEntityToJson(
        CreditCardSLimitsUpdateRequestEntity instance) =>
    <String, dynamic>{
      'OnlinePurchase': instance.isOnlinePurchase,
      'OnlinePurchaseLimit': instance.onlinePurchase,
      'ATM': instance.isAtmWithdrawal,
      'ATMLimit': instance.atmWithdrawal,
      'Merchant': instance.isMerchantsPayments,
      'MerchantLimit': instance.merchantsPayments,
      'ContactLessPayment': instance.isContactLessPayments,
      'SecureCode': instance.secureCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
