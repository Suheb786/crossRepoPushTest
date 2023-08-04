// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_transfer_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRTransferContentEntity _$QRTransferContentEntityFromJson(
        Map<String, dynamic> json) =>
    QRTransferContentEntity(
      transferDate: json['transferDate'] as String?,
      name: json['name'] as String?,
      amount: json['amount'] as num?,
      iban: json['iban'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$QRTransferContentEntityToJson(
        QRTransferContentEntity instance) =>
    <String, dynamic>{
      'iban': instance.iban,
      'transferDate': instance.transferDate,
      'name': instance.name,
      'amount': instance.amount,
      'reference': instance.reference,
    };
