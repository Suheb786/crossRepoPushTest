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
        : DashboardAccountEntity.fromJson(
            json['creditCard'] as Map<String, dynamic>),
    blinkBornDate: json['blinkWasBorn'] as String?,
    blinkJoinedDate: json['youJoinedBlink'] as String?,
    debitCardActivated: json['debitCardActivated'] as bool?,
    isApplied: json['isApplied'] as bool?,
    isDelivered: json['isDelivered'] as bool?,
  );
}

Map<String, dynamic> _$DashboardDataEntityToJson(
        DashboardDataEntity instance) =>
    <String, dynamic>{
      'account': instance.account,
      'creditCard': instance.creditCard,
      'isApplied': instance.isApplied,
      'isDelivered': instance.isDelivered,
      'debitCardActivated': instance.debitCardActivated,
      'youJoinedBlink': instance.blinkJoinedDate,
      'blinkWasBorn': instance.blinkBornDate,
    };
