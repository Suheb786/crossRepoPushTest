// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_card_limit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditCardLimitEntity _$GetCreditCardLimitEntityFromJson(
    Map<String, dynamic> json) {
  return GetCreditCardLimitEntity(
    internetLimitMin: json['monthlyinternettranmin'] as String?,
    internetLimitMax: json['monthlyinternettranmax'] as String?,
    internetCurrentLimit: json['dailycashnbtranlimit'] as String?,
  );
}

Map<String, dynamic> _$GetCreditCardLimitEntityToJson(
        GetCreditCardLimitEntity instance) =>
    <String, dynamic>{
      'monthlyinternettranmin': instance.internetLimitMin,
      'monthlyinternettranmax': instance.internetLimitMax,
      'dailycashnbtranlimit': instance.internetCurrentLimit,
    };
