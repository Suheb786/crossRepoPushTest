// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryEntity _$BeneficiaryEntityFromJson(Map<String, dynamic> json) {
  return BeneficiaryEntity(
    nickName: json['nickName'] as String?,
    fullName: json['fullName'] as String?,
    profileImage: json['profileImage'] as String?,
    beneficiaryAddress: json['beneficiaryAddress'] as String?,
    accountNo: json['accountNo'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
    purposeDetails: json['purposeDetails'] as String?,
    bankName: json['bankName'] as String?,
    iban: json['iban'] as String?,
    purpose: json['purpose'] as String?,
    id: json['id'] as String?,
    beneType: json['beneType'] as String?,
    purposeType: json['purposeType'] as String?,
    detCustomerType: json['detCustomerType'] as String?,
  );
}

Map<String, dynamic> _$BeneficiaryEntityToJson(BeneficiaryEntity instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'fullName': instance.fullName,
      'profileImage': instance.profileImage,
      'id': instance.id,
      'accountNo': instance.accountNo,
      'iban': instance.iban,
      'purpose': instance.purpose,
      'purposeDetails': instance.purposeDetails,
      'mobileNumber': instance.mobileNumber,
      'beneficiaryAddress': instance.beneficiaryAddress,
      'bankName': instance.bankName,
      'beneType': instance.beneType,
      'purposeType': instance.purposeType,
      'detCustomerType': instance.detCustomerType,
    };
