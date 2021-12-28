// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequestEntity _$TransferRequestEntityFromJson(
    Map<String, dynamic> json) {
  return TransferRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    toAmount: json['ToAmount'] as num,
    transferType: json['TransferType'] as String?,
    localEq: json['LocalEq'] as num,
    beneficiaryImage: json['BeneficiaryImage'] as String?,
    beneficiaryId: json['BeneficiaryId'] as String?,
    memo: json['Memo'] as String,
    toAccount: json['ToAccount'] as String,
    isFriend: json['IsFriend'] as bool,
    getToken: json['getToken'] as bool,
    otpCode: json['OtpCode'] as String?,
  );
}

Map<String, dynamic> _$TransferRequestEntityToJson(
        TransferRequestEntity instance) =>
    <String, dynamic>{
      'BeneficiaryId': instance.beneficiaryId,
      'OtpCode': instance.otpCode,
      'TransferType': instance.transferType,
      'BeneficiaryImage': instance.beneficiaryImage,
      'IsFriend': instance.isFriend,
      'ToAmount': instance.toAmount,
      'LocalEq': instance.localEq,
      'Memo': instance.memo,
      'ToAccount': instance.toAccount,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
