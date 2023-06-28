// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDetailEntity _$VoucherDetailEntityFromJson(Map<String, dynamic> json) =>
    VoucherDetailEntity(
      id: json['id'] as String?,
      customerName: json['customerName'] as String? ?? '',
      cardImage: json['cardImage'] as String? ?? '',
      deliveryChannel: json['deliveryChannel'] as String? ?? '',
      emailAddress: json['emailAddress'] as String? ?? '',
      referenceNo: json['referenceNo'] as String? ?? '',
      creationDate: json['creationDate'] as String? ?? '',
      lineItems: (json['lineItems'] as List<dynamic>?)
              ?.map((e) =>
                  VoucherLineItemEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VoucherDetailEntityToJson(
        VoucherDetailEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'cardImage': instance.cardImage,
      'deliveryChannel': instance.deliveryChannel,
      'emailAddress': instance.emailAddress,
      'referenceNo': instance.referenceNo,
      'creationDate': instance.creationDate,
      'lineItems': instance.lineItems,
    };
