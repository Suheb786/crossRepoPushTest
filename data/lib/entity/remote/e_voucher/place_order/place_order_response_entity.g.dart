// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderResponseEntity _$PlaceOrderResponseEntityFromJson(Map<String, dynamic> json) =>
    PlaceOrderResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceOrderResponseEntityToJson(PlaceOrderResponseEntity instance) => <String, dynamic>{
      'response': instance.response,
    };

PlaceOrderContentEntity _$PlaceOrderContentEntityFromJson(Map<String, dynamic> json) =>
    PlaceOrderContentEntity(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      deliveryChannel: json['deliveryChannel'] as String,
      emailAddress: json['emailAddress'] as String?,
      smsMobileNumber: json['smsMobileNumber'] as String?,
      referenceNo: json['referenceNo'] as String,
      creationDate: json['creationDate'] as String,
      placementDate: json['placementDate'] as String,
      lineItems: (json['lineItems'] as List<dynamic>)
          .map((e) => LineItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceOrderContentEntityToJson(PlaceOrderContentEntity instance) => <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'deliveryChannel': instance.deliveryChannel,
      'emailAddress': instance.emailAddress,
      'smsMobileNumber': instance.smsMobileNumber,
      'referenceNo': instance.referenceNo,
      'creationDate': instance.creationDate,
      'placementDate': instance.placementDate,
      'lineItems': instance.lineItems,
    };

LineItemEntity _$LineItemEntityFromJson(Map<String, dynamic> json) => LineItemEntity(
      lineNumber: json['lineNumber'] as int,
      cardItemId: json['cardItemId'] as String,
      cardItemName: json['cardItemName'] as String?,
      value: (json['value'] as num).toDouble(),
      currency: json['currency'] as String,
      certificateGenerationKey: json['certificateGenerationKey'] as String,
      status: json['status'] as String,
      claimURL: json['claimURL'] as String,
      settlementCurrency: json['settlementCurrency'] as String,
      exchangeRate: json['exchangeRate'] as String,
      settlementPrice: json['settlementPrice'] as String,
      netPrice: json['netPrice'] as String,
    );

Map<String, dynamic> _$LineItemEntityToJson(LineItemEntity instance) => <String, dynamic>{
      'lineNumber': instance.lineNumber,
      'cardItemId': instance.cardItemId,
      'cardItemName': instance.cardItemName,
      'value': instance.value,
      'currency': instance.currency,
      'certificateGenerationKey': instance.certificateGenerationKey,
      'status': instance.status,
      'claimURL': instance.claimURL,
      'settlementCurrency': instance.settlementCurrency,
      'exchangeRate': instance.exchangeRate,
      'settlementPrice': instance.settlementPrice,
      'netPrice': instance.netPrice,
    };
