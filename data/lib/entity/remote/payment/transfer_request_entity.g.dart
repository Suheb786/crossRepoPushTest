// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequestEntity _$TransferRequestEntityFromJson(Map<String, dynamic> json) => TransferRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      toAmount: json['ToAmount'] as num? ?? 0,
      nickName: json['NickName'] as String? ?? "",
      transferType: json['TransferType'] as String? ?? "",
      localEq: json['LocalEq'] as num? ?? 0,
      beneficiaryImage: json['BeneficiaryImage'] as String? ?? "",
      beneficiaryId: json['BeneficiaryId'] as String? ?? "",
      memo: json['Memo'] as String? ?? "",
      toAccount: json['ToAccount'] as String? ?? "",
      isFriend: json['IsFriend'] as bool? ?? false,
      type: json['Type'] as String? ?? "",
      detCustomerType: json['DetCustomerType'] as String? ?? "",
      getToken: json['getToken'] as bool? ?? true,
      otpCode: json['OtpCode'] as String? ?? "",
      recipientName: json['RecipientName'] as String?,
      recipientAddress: json['RecipientAddress'] as String?,
    );

Map<String, dynamic> _$TransferRequestEntityToJson(TransferRequestEntity instance) => <String, dynamic>{
      'BeneficiaryId': instance.beneficiaryId,
      'OtpCode': instance.otpCode,
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
      'RecipientName': instance.recipientName,
      'RecipientAddress': instance.recipientAddress,
      'baseClass': instance.baseData,
    };
