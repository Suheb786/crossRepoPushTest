// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferResponseEntity _$TransferResponseEntityFromJson(Map<String, dynamic> json) {
  return TransferResponseEntity(
    beneficiaryId: json['beneficiaryId'] as String?,
    transferType: json['transferType'] as String?,
    beneficiaryImage: json['beneficiaryImage'] as String?,
    toAmount: json['toAmount'] as num?,
    localEq: json['localEq'] as num?,
    toAccount: json['toAccount'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$TransferResponseEntityToJson(TransferResponseEntity instance) => <String, dynamic>{
      'beneficiaryId': instance.beneficiaryId,
      'transferType': instance.transferType,
      'beneficiaryImage': instance.beneficiaryImage,
      'toAmount': instance.toAmount,
      'localEq': instance.localEq,
      'toAccount': instance.toAccount,
      'name': instance.name,
    };
