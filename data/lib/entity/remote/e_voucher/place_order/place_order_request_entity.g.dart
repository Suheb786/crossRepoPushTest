// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderRequestEntity _$PlaceOrderRequestEntityFromJson(Map<String, dynamic> json) =>
    PlaceOrderRequestEntity(
      sourceAccount: json['sourceAccount'] as String? ?? '',
      sourceCurrency: json['sourceCurrency'] as String? ?? '',
      cardItemId: json['cardItemId'] as String? ?? '',
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble() ?? 0.0,
      voucherCurrency: json['VoucherCurrency'] as String? ?? '',
      reconciliationCurrency: json['reconciliationCurrency'] as String? ?? '',
      equivalentAmount: json['EquivalentAmount'] as String? ?? '0.0',
      denomination: json['Denomination'] as int? ?? 0,
      discount: json['Discount'] as String? ?? '',
      categories: json['Categories'] as String? ?? '',
      voucherName: json['VoucherName'] as String? ?? '',
      productId: json['ProductId'] as String? ?? '',
      productName: json['ProductName'] as String? ?? '',
      otpCode: json['OtpCode'] as String? ?? '',
      getToken: json['GetToken'] as bool? ?? false,
      BaseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PlaceOrderRequestEntityToJson(PlaceOrderRequestEntity instance) => <String, dynamic>{
      'sourceAccount': instance.sourceAccount,
      'sourceCurrency': instance.sourceCurrency,
      'cardItemId': instance.cardItemId,
      'exchangeRate': instance.exchangeRate,
      'VoucherCurrency': instance.voucherCurrency,
      'reconciliationCurrency': instance.reconciliationCurrency,
      'EquivalentAmount': instance.equivalentAmount,
      'Denomination': instance.denomination,
      'Discount': instance.discount,
      'Categories': instance.categories,
      'VoucherName': instance.voucherName,
      'ProductId': instance.productId,
      'ProductName': instance.productName,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.BaseClass,
    };
