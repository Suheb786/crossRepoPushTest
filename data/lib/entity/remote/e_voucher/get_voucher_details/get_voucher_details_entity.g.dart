// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_voucher_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVoucherDetailsEntity _$GetVoucherDetailsEntityFromJson(Map<String, dynamic> json) =>
    GetVoucherDetailsEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      usageInstructions: json['usageInstructions'] as String?,
      termsAndConditions: json['termsAndConditions'] as String?,
      giftCardInformation: json['giftCardInformation'] as String?,
      brand: json['brand'] as String?,
      currency: json['currency'] as String?,
      fromValue: (json['fromValue'] as num?)?.toDouble(),
      toValue: (json['toValue'] as num?)?.toDouble(),
      cardFaceImage: json['cardFaceImage'] as String?,
      cardFaceHash: json['cardFaceHash'] as String?,
      productId: (json['productId'] as num?)?.toDouble(),
      categories: (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
      discount: json['discount'] as String?,
      countryCode: json['countryCode'] as String?,
      activationFees: json['activationFees'] as String?,
      fulfillmentFees: json['fulfillmentFees'] as String?,
      shippingFees: json['shippingFees'] as String?,
      customizationFees: json['customizationFees'] as String?,
      refundFees: json['refundFees'] as String?,
      otherFees: json['otherFees'] as String?,
      reconciliationCurrency: json['reconciliationCurrency'] as String?,
      exchangeRate: json['exchangeRate'] as String?,
    );

Map<String, dynamic> _$GetVoucherDetailsEntityToJson(GetVoucherDetailsEntity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'usageInstructions': instance.usageInstructions,
      'termsAndConditions': instance.termsAndConditions,
      'giftCardInformation': instance.giftCardInformation,
      'brand': instance.brand,
      'currency': instance.currency,
      'fromValue': instance.fromValue,
      'toValue': instance.toValue,
      'cardFaceImage': instance.cardFaceImage,
      'cardFaceHash': instance.cardFaceHash,
      'productId': instance.productId,
      'categories': instance.categories,
      'discount': instance.discount,
      'countryCode': instance.countryCode,
      'activationFees': instance.activationFees,
      'fulfillmentFees': instance.fulfillmentFees,
      'shippingFees': instance.shippingFees,
      'customizationFees': instance.customizationFees,
      'refundFees': instance.refundFees,
      'otherFees': instance.otherFees,
      'reconciliationCurrency': instance.reconciliationCurrency,
      'exchangeRate': instance.exchangeRate,
    };
