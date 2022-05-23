// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDataEntity _$DashboardDataEntityFromJson(Map<String, dynamic> json) {
  return DashboardDataEntity(
    account: json['account'] == null
        ? null
        : DashboardAccountEntity.fromJson(
            json['account'] as Map<String, dynamic>),
    creditCard: (json['creditCard'] as List<dynamic>?)
        ?.map((e) => DashboardCardEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    mobileNumber: json['mobileNumber'] as String?,
    blinkBornDate: json['blinkWasBorn'] == null
        ? null
        : DateTime.parse(json['blinkWasBorn'] as String),
    blinkJoinedDate: json['youJoinedBlink'] == null
        ? null
        : DateTime.parse(json['youJoinedBlink'] as String),
    mobileCode: json['mobileCode'] as String?,
    somethingWrong: json['somethingWrong'] as bool?,
    debitCardSomethingWrong: json['debitCardSomethingWrong'] as bool?,
    isCreditCard: json['isCreditCard'] as bool?,
    debitCard: (json['debitCard'] as List<dynamic>?)
        ?.map(
            (e) => DashboardDebitCardEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DashboardDataEntityToJson(
        DashboardDataEntity instance) =>
    <String, dynamic>{
      'account': instance.account,
      'creditCard': instance.creditCard,
      'debitCard': instance.debitCard,
      'mobileNumber': instance.mobileNumber,
      'mobileCode': instance.mobileCode,
      'youJoinedBlink': instance.blinkJoinedDate?.toIso8601String(),
      'blinkWasBorn': instance.blinkBornDate?.toIso8601String(),
      'somethingWrong': instance.somethingWrong,
      'debitCardSomethingWrong': instance.debitCardSomethingWrong,
      'isCreditCard': instance.isCreditCard,
    };
