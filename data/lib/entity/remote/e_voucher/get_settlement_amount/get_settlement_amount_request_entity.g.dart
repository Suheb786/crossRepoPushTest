// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_settlement_amount_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSettlementAmountRequestEntity _$GetSettlementAmountRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetSettlementAmountRequestEntity(
      Denomination: json['Denomination'] as String?,
      exchangeRate: json['exchangeRate'] as String?,
      reconcilationCurrency: json['reconcilationCurrency'] as String?,
      Discount: json['Discount'] as String?,
      VoucherName: json['VoucherName'] as String?,
      VoucherCategory: json['VoucherCategory'] as String?,
      AccountNo: json['AccountNo'] as String?,
      GetToken: json['GetToken'] as bool?,
      BaseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetSettlementAmountRequestEntityToJson(
        GetSettlementAmountRequestEntity instance) =>
    <String, dynamic>{
      'Denomination': instance.Denomination,
      'exchangeRate': instance.exchangeRate,
      'reconcilationCurrency': instance.reconcilationCurrency,
      'Discount': instance.Discount,
      'VoucherName': instance.VoucherName,
      'VoucherCategory': instance.VoucherCategory,
      'AccountNo': instance.AccountNo,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
