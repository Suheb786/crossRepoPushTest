// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_line_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherLineItemEntity _$VoucherLineItemEntityFromJson(
        Map<String, dynamic> json) =>
    VoucherLineItemEntity(
      lineNumber: json['lineNumber'] as int?,
      cardItemId: json['cardItemId'] as String?,
      value: json['value'] as num?,
      status: json['status'] as String? ?? '',
      claimURL: json['claimURL'] as String? ?? '',
      cardItemName: json['cardItemName'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
    );

Map<String, dynamic> _$VoucherLineItemEntityToJson(
        VoucherLineItemEntity instance) =>
    <String, dynamic>{
      'lineNumber': instance.lineNumber,
      'cardItemId': instance.cardItemId,
      'value': instance.value,
      'status': instance.status,
      'claimURL': instance.claimURL,
      'cardItemName': instance.cardItemName,
      'currency': instance.currency,
    };
