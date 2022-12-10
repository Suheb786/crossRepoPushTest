// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_qr_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferQRRequestEntity _$TransferQRRequestEntityFromJson(Map<String, dynamic> json) {
  return TransferQRRequestEntity(
    toAmount: json['ToAmount'] as String?,
    toAccount: json['toAccount'] as String?,
    qrRequestId: json['QrRequestId'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$TransferQRRequestEntityToJson(TransferQRRequestEntity instance) => <String, dynamic>{
      'QrRequestId': instance.qrRequestId,
      'GetToken': instance.getToken,
      'ToAmount': instance.toAmount,
      'toAccount': instance.toAccount,
      'BaseClass': instance.baseData,
    };
