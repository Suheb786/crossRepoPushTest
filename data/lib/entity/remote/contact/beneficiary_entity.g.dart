// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryEntity _$BeneficiaryEntityFromJson(Map<String, dynamic> json) =>
    BeneficiaryEntity(
      nickName: json['nickName'] as String? ?? "",
      fullName: json['fullName'] as String? ?? "",
      profileImage: json['image'] as String? ?? "",
      beneficiaryAddress: json['beneficiaryAddress'] as String? ?? "",
      accountNo: json['accountNo'] as String? ?? "",
      mobileNumber: json['mobileNumber'] as String? ?? "",
      purposeDetails: json['purposeDetails'] as String? ?? "",
      bankName: json['bankName'] as String? ?? "",
      iban: json['beneficiaryIban'] as String? ?? "",
      purpose: json['purpose'] as String? ?? "",
      id: json['id'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      beneType: json['beneficiaryType'] as String? ?? "",
      purposeType: json['purposeType'] as String? ?? "",
      detCustomerType: json['detCustomerType'] as String? ?? "",
      limit: json['limit'] as num?,
      purposeParent: json['purposeParent'] as String? ?? "",
      purposeParentDetails: json['purposeParentDetails'] as String? ?? "",
    );

Map<String, dynamic> _$BeneficiaryEntityToJson(BeneficiaryEntity instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'fullName': instance.fullName,
      'image': instance.profileImage,
      'id': instance.id,
      'userId': instance.userId,
      'accountNo': instance.accountNo,
      'beneficiaryIban': instance.iban,
      'purpose': instance.purpose,
      'purposeDetails': instance.purposeDetails,
      'mobileNumber': instance.mobileNumber,
      'beneficiaryAddress': instance.beneficiaryAddress,
      'bankName': instance.bankName,
      'beneficiaryType': instance.beneType,
      'purposeType': instance.purposeType,
      'purposeParent': instance.purposeParent,
      'purposeParentDetails': instance.purposeParentDetails,
      'limit': instance.limit,
      'detCustomerType': instance.detCustomerType,
    };
