// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_qr_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateQRRequestEntity _$GenerateQRRequestEntityFromJson(Map<String, dynamic> json) {
  return GenerateQRRequestEntity(
    amount: json['Amount'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$GenerateQRRequestEntityToJson(GenerateQRRequestEntity instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
