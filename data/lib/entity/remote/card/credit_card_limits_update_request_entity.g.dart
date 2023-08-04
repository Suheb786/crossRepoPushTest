// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_limits_update_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardSLimitsUpdateRequestEntity
    _$CreditCardSLimitsUpdateRequestEntityFromJson(Map<String, dynamic> json) =>
        CreditCardSLimitsUpdateRequestEntity(
          getToken: json['GetToken'] as bool? ?? true,
          atmWithdrawal: json['ATMLimit'] as num? ?? 0,
          merchantsPayments: json['MerchantLimit'] as num? ?? 0,
          onlinePurchase: json['OnlinePurchaseLimit'] as num? ?? 0,
          isAtmWithdrawal: json['ATM'] as bool? ?? false,
          isMerchantsPayments: json['Merchant'] as bool? ?? false,
          isOnlinePurchase: json['OnlinePurchase'] as bool? ?? false,
          isContactLessPayments: json['ContactLessPayment'] as bool? ?? false,
          baseData: json['BaseClass'] as Map<String, dynamic>?,
          secureCode: json['SecureCode'] as String? ?? "",
          contactLessPaymentLimit: json['ContactLessPaymentLimit'] as num? ?? 0,
        );

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
      'ContactLessPaymentLimit': instance.contactLessPaymentLimit,
      'SecureCode': instance.secureCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
