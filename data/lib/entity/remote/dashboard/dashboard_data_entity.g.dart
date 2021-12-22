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
    creditCard: json['creditCard'] == null
        ? null
        : DashboardCardEntity.fromJson(
            json['creditCard'] as Map<String, dynamic>),
    blinkBornDate: json['blinkWasBorn'] == null
        ? null
        : DateTime.parse(json['blinkWasBorn'] as String),
    blinkJoinedDate: json['youJoinedBlink'] == null
        ? null
        : DateTime.parse(json['youJoinedBlink'] as String),
    debitCardActivated: json['debitCardActivated'],
    isApplied: json['isApplied'] as bool?,
    isDebitDelivered: json['isDebitDelivered'],
    creditCardActivated: json['creditCardActivated'] as String?,
    isCreditDelivered: json['isCreditDelivered'],
    debitCard: json['debitCard'] == null
        ? null
        : DashboardDebitCardEntity.fromJson(
            json['debitCard'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DashboardDataEntityToJson(
        DashboardDataEntity instance) =>
    <String, dynamic>{
      'account': instance.account,
      'creditCard': instance.creditCard,
      'debitCard': instance.debitCard,
      'isApplied': instance.isApplied,
      'isCreditDelivered': instance.isCreditDelivered,
      'isDebitDelivered': instance.isDebitDelivered,
      'debitCardActivated': instance.debitCardActivated,
      'creditCardActivated': instance.creditCardActivated,
      'youJoinedBlink': instance.blinkJoinedDate?.toIso8601String(),
      'blinkWasBorn': instance.blinkBornDate?.toIso8601String(),
    };
