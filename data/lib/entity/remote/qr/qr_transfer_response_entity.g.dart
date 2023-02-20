// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_transfer_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRTransferResponseEntity _$QRTransferResponseEntityFromJson(
    Map<String, dynamic> json) {
  return QRTransferResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QRTransferResponseEntityToJson(
        QRTransferResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
