// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardCardEntity _$DashboardCardEntityFromJson(Map<String, dynamic> json) {
  return DashboardCardEntity(
    accountTitle: json['accountTitle'] as String?,
    availableBalance: json['availableBalance'] as num?,
    accountNo: json['accountNo'] as String?,
    iban: json['iban'] as String?,
    cardNo: json['cardNo'] as String?,
  );
}

Map<String, dynamic> _$DashboardCardEntityToJson(
        DashboardCardEntity instance) =>
    <String, dynamic>{
      'accountTitle': instance.accountTitle,
      'availableBalance': instance.availableBalance,
      'accountNo': instance.accountNo,
      'iban': instance.iban,
      'cardNo': instance.cardNo,
    };
