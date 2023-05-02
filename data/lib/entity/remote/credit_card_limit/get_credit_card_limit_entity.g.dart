// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_limit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardLimitEntity _$GetCreditCardLimitEntityFromJson(
        Map<String, dynamic> json) =>
    GetCreditCardLimitEntity(
      isATM: json['isATM'] as bool? ?? false,
      atmCurrentLimit: json['atmCurrentLimit'] as String? ?? "0",
      atmMaxLimit: json['atmmaxLimit'] as String? ?? "0",
      isMerchant: json['isMarchant'] as bool? ?? false,
      merchantCurrentLimit: json['marchantCurrentLimit'] as String? ?? "0",
      merchantMAXLimit: json['marchantMAXLimit'] as String? ?? "0",
      isOnlinePurchase: json['isOnlinePurchase'] as bool? ?? false,
      onlinePurchaseCurrentLimit:
          json['onlinePurchaseCurrentLimit'] as String? ?? "0",
      onlinePurchaseMAXLimit: json['onlinePurchaseMAXLimit'] as String? ?? "0",
      isContactLess: json['isContactLess'] as bool? ?? false,
    );

Map<String, dynamic> _$GetCreditCardLimitEntityToJson(
        GetCreditCardLimitEntity instance) =>
    <String, dynamic>{
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
