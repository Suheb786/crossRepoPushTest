// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardAccountEntity _$DashboardAccountEntityFromJson(
        Map<String, dynamic> json) =>
    DashboardAccountEntity(
      accountTitle: json['accountTitle'] as String? ?? "",
      availableBalance: json['availableBalance'] as num? ?? 0.0,
      accountNo: json['accountNo'] as String? ?? "",
      iban: json['iban'] as String? ?? "",
      cardNo: json['cardNo'] as String? ?? "",
    );

Map<String, dynamic> _$DashboardAccountEntityToJson(
        DashboardAccountEntity instance) =>
    <String, dynamic>{
      'accountTitle': instance.accountTitle,
      'availableBalance': instance.availableBalance,
      'accountNo': instance.accountNo,
      'iban': instance.iban,
      'cardNo': instance.cardNo,
    };
