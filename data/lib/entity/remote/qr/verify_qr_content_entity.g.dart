// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_qr_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyQRContentEntity _$VerifyQRContentEntityFromJson(Map<String, dynamic> json) => VerifyQRContentEntity(
      toAccount: json['toAccount'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      amount: json['amount'] as String?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$VerifyQRContentEntityToJson(VerifyQRContentEntity instance) => <String, dynamic>{
      'requestId': instance.requestId,
      'toAccount': instance.toAccount,
      'accountHolderName': instance.accountHolderName,
      'amount': instance.amount,
    };
