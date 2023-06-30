// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card_limits_update_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitCardSLimitsUpdateRequestEntity
    _$DebitCardSLimitsUpdateRequestEntityFromJson(Map<String, dynamic> json) =>
        DebitCardSLimitsUpdateRequestEntity(
          getToken: json['getToken'] as bool? ?? true,
          tokenizedPan: json['TokenizedPan'] as String? ?? "",
          atmWithdrawal: json['atmWithdrawal'] as num? ?? 0,
          merchantsPayments: json['merchantsPayments'] as num? ?? 0,
          onlinePurchase: json['onlinePurchase'] as num? ?? 0,
          contactLessPayments: json['contactLessPayments'] as num? ?? 0,
          isAtmWithdrawal: json['isAtmWithdrawal'] as bool? ?? false,
          isMerchantsPayments: json['isMerchantsPayments'] as bool? ?? false,
          isOnlinePurchase: json['isOnlinePurchase'] as bool? ?? false,
          isContactLessPayments:
              json['isContactLessPayments'] as bool? ?? false,
          updateEcom: json['updateEcom'] as bool?,
          baseData: json['baseClass'] as Map<String, dynamic>?,
        );

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
      'updateEcom': instance.updateEcom,
      'baseClass': instance.baseData,
    };
