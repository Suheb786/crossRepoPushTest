// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_settlement_amount_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSettlementAmountRequestEntity _$GetSettlementAmountRequestEntityFromJson(Map<String, dynamic> json) =>
    GetSettlementAmountRequestEntity(
      Amount: json['Amount'] as String?,
      FromCurrency: json['FromCurrency'] as String?,
      ToCurrency: json['ToCurrency'] as String?,
      GetToken: json['GetToken'] as bool?,
      BaseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetSettlementAmountRequestEntityToJson(GetSettlementAmountRequestEntity instance) =>
    <String, dynamic>{
      'Amount': instance.Amount,
      'FromCurrency': instance.FromCurrency,
      'ToCurrency': instance.ToCurrency,
      'GetToken': instance.GetToken,
      'BaseClass': instance.BaseClass,
    };
