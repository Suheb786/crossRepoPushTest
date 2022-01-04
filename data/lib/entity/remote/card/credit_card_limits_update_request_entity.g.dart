// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_limits_update_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardSLimitsUpdateRequestEntity
    _$CreditCardSLimitsUpdateRequestEntityFromJson(Map<String, dynamic> json) {
  return CreditCardSLimitsUpdateRequestEntity(
    getToken: json['getToken'] as bool?,
    atmWithdrawal: json['atmWithdrawal'] as num?,
    merchantsPayments: json['merchantsPayments'] as num?,
    onlinePurchase: json['onlinePurchase'] as num?,
    contactLessPayments: json['contactLessPayments'] as num?,
    isAtmWithdrawal: json['isAtmWithdrawal'] as bool?,
    isMerchantsPayments: json['isMerchantsPayments'] as bool?,
    isOnlinePurchase: json['isOnlinePurchase'] as bool?,
    isContactLessPayments: json['isContactLessPayments'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$CreditCardSLimitsUpdateRequestEntityToJson(
        CreditCardSLimitsUpdateRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'atmWithdrawal': instance.atmWithdrawal,
      'merchantsPayments': instance.merchantsPayments,
      'onlinePurchase': instance.onlinePurchase,
      'contactLessPayments': instance.contactLessPayments,
      'isAtmWithdrawal': instance.isAtmWithdrawal,
      'isMerchantsPayments': instance.isMerchantsPayments,
      'isOnlinePurchase': instance.isOnlinePurchase,
      'isContactLessPayments': instance.isContactLessPayments,
      'baseClass': instance.baseData,
    };
