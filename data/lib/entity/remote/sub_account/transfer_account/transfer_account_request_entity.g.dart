// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountToAccountTransferRequestEntity
    _$AccountToAccountTransferRequestEntityFromJson(
            Map<String, dynamic> json) =>
        AccountToAccountTransferRequestEntity(
          fromAccount: json['FromAccount'] as String?,
          toAccount: json['ToAccount'] as String?,
          getToken: json['GetToken'] as bool?,
          transferAmount: (json['TransferAmount'] as num?)?.toDouble(),
          baseClass: json['BaseClass'] as Map<String, dynamic>?,
        );

Map<String, dynamic> _$AccountToAccountTransferRequestEntityToJson(
        AccountToAccountTransferRequestEntity instance) =>
    <String, dynamic>{
      'FromAccount': instance.fromAccount,
      'ToAccount': instance.toAccount,
      'TransferAmount': instance.transferAmount,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
