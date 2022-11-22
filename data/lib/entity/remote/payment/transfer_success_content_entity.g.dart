// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_success_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferSuccessContentEntity _$TransferSuccessContentEntityFromJson(Map<String, dynamic> json) {
  return TransferSuccessContentEntity(
    amount: json['amount'] as num?,
    name: json['name'] as String?,
    iban: json['iban'] as String?,
    transferDate: json['transferDate'] == null ? null : DateTime.parse(json['transferDate'] as String),
    reference: json['reference'] as String?,
  );
}

Map<String, dynamic> _$TransferSuccessContentEntityToJson(TransferSuccessContentEntity instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'name': instance.name,
      'iban': instance.iban,
      'transferDate': instance.transferDate?.toIso8601String(),
      'reference': instance.reference,
    };
