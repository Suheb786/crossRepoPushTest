// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_limit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardLimitEntity _$GetCreditCardLimitEntityFromJson(Map<String, dynamic> json) {
  return GetCreditCardLimitEntity(
    isATM: json['isATM'] as bool?,
    atmCurrentLimit: json['atmCurrentLimit'] as String?,
    atmMaxLimit: json['atmmaxLimit'] as String?,
    isMerchant: json['isMarchant'] as bool?,
    merchantCurrentLimit: json['marchantCurrentLimit'] as String?,
    merchantMAXLimit: json['marchantMAXLimit'] as String?,
    isOnlinePurchase: json['isOnlinePurchase'] as bool?,
    onlinePurchaseCurrentLimit: json['onlinePurchaseCurrentLimit'] as String?,
    onlinePurchaseMAXLimit: json['onlinePurchaseMAXLimit'] as String?,
    isContactLess: json['isContactLess'] as bool?,
  );
}

Map<String, dynamic> _$GetCreditCardLimitEntityToJson(GetCreditCardLimitEntity instance) => <String, dynamic>{
      'isATM': instance.isATM,
      'atmCurrentLimit': instance.atmCurrentLimit,
      'atmmaxLimit': instance.atmMaxLimit,
      'isMarchant': instance.isMerchant,
      'marchantCurrentLimit': instance.merchantCurrentLimit,
      'marchantMAXLimit': instance.merchantMAXLimit,
      'isOnlinePurchase': instance.isOnlinePurchase,
      'onlinePurchaseCurrentLimit': instance.onlinePurchaseCurrentLimit,
      'onlinePurchaseMAXLimit': instance.onlinePurchaseMAXLimit,
      'isContactLess': instance.isContactLess,
    };
