// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limits_update_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardSLimitsUpdateRequestEntity _$DebitCardSLimitsUpdateRequestEntityFromJson(Map<String, dynamic> json) {
  return DebitCardSLimitsUpdateRequestEntity(
    getToken: json['getToken'] as bool?,
    tokenizedPan: json['TokenizedPan'] as String?,
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

Map<String, dynamic> _$DebitCardSLimitsUpdateRequestEntityToJson(
        DebitCardSLimitsUpdateRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'TokenizedPan': instance.tokenizedPan,
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
