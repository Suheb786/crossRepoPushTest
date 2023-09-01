// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_qr_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateQRRequestEntity _$GenerateQRRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GenerateQRRequestEntity(
      amount: json['Amount'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>?,
      fromAccount: json['FromAccount'] as String? ?? '',
    );

Map<String, dynamic> _$GenerateQRRequestEntityToJson(
        GenerateQRRequestEntity instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'FromAccount': instance.fromAccount,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
