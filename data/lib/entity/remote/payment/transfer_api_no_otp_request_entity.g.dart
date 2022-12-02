// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_api_no_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferApiNoOtpRequestEntity _$TransferApiNoOtpRequestEntityFromJson(
    Map<String, dynamic> json) {
  return TransferApiNoOtpRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    toAmount: json['ToAmount'] as num,
    nickName: json['NickName'] as String?,
    transferType: json['TransferType'] as String?,
    localEq: json['LocalEq'] as num,
    beneficiaryImage: json['BeneficiaryImage'] as String?,
    beneficiaryId: json['BeneficiaryId'] as String?,
    memo: json['Memo'] as String,
    toAccount: json['ToAccount'] as String,
    isFriend: json['IsFriend'] as bool,
    type: json['Type'] as String?,
    detCustomerType: json['DetCustomerType'] as String?,
    getToken: json['getToken'] as bool,
  );
}

Map<String, dynamic> _$TransferApiNoOtpRequestEntityToJson(
        TransferApiNoOtpRequestEntity instance) =>
    <String, dynamic>{
      'BeneficiaryId': instance.beneficiaryId,
      'TransferType': instance.transferType,
      'BeneficiaryImage': instance.beneficiaryImage,
      'IsFriend': instance.isFriend,
      'ToAmount': instance.toAmount,
      'LocalEq': instance.localEq,
      'Memo': instance.memo,
      'ToAccount': instance.toAccount,
      'Type': instance.type,
      'DetCustomerType': instance.detCustomerType,
      'getToken': instance.getToken,
      'NickName': instance.nickName,
      'baseClass': instance.baseData,
    };
