// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherItemEntity _$VoucherItemEntityFromJson(Map<String, dynamic> json) =>
    VoucherItemEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      usageInstructions: json['usageInstructions'] as String? ?? '',
      termsAndConditions: json['termsAndConditions'] as String? ?? '',
      giftCardInformation: json['giftCardInformation'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      fromValue: json['fromValue'] as num? ?? 0.0,
      toValue: json['toValue'] as num? ?? 0.0,
      cardFaceImage: json['cardFaceImage'] as String? ?? '',
      cardFaceHash: json['cardFaceHash'] as String? ?? '',
      productId: json['productId'] as num? ?? 0.0,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      discount: json['discount'] as String? ?? '',
      countryCode: json['countryCode'] as String? ?? '',
    );

Map<String, dynamic> _$VoucherItemEntityToJson(VoucherItemEntity instance) =>
    <String, dynamic>{
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
    };
