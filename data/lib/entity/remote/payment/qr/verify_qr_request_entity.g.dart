// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_qr_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyQRRequestEntity _$VerifyQRRequestEntityFromJson(
        Map<String, dynamic> json) =>
    VerifyQRRequestEntity(
      source: json['Source'] as String?,
      qrRequestId: json['QrRequestId'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$VerifyQRRequestEntityToJson(
        VerifyQRRequestEntity instance) =>
    <String, dynamic>{
      'QrRequestId': instance.qrRequestId,
      'Source': instance.source,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
