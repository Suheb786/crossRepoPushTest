// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_api_verify_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferApiVerifyRequestEntity _$TransferApiVerifyRequestEntityFromJson(
        Map<String, dynamic> json) =>
    TransferApiVerifyRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>?,
      amount: json['Amount'] as String? ?? "",
    );

Map<String, dynamic> _$TransferApiVerifyRequestEntityToJson(
        TransferApiVerifyRequestEntity instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
