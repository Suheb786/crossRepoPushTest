// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBeneficiaryRequest _$AddBeneficiaryRequestFromJson(Map<String, dynamic> json) {
  return AddBeneficiaryRequest(
    nickName: json['NickName'] as String?,
    fullName: json['FullName'] as String?,
    accountNo: json['AccountNo'] as String?,
    iBan: json['Iban'] as String?,
    bankName: json['BankName'] as String?,
    purpose: json['Purpose'] as String?,
    purposeDetails: json['PurposeDetails'] as String?,
    image: json['Image'] as String?,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AddBeneficiaryRequestToJson(AddBeneficiaryRequest instance) => <String, dynamic>{
      'NickName': instance.nickName,
      'FullName': instance.fullName,
      'AccountNo': instance.accountNo,
      'Iban': instance.iBan,
      'BankName': instance.bankName,
      'Purpose': instance.purpose,
      'PurposeDetails': instance.purposeDetails,
      'Image': instance.image,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
