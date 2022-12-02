// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBeneficiaryRequest _$UpdateBeneficiaryRequestFromJson(
    Map<String, dynamic> json) {
  return UpdateBeneficiaryRequest(
    beneficiaryId: json['BeneficiaryID'] as String,
    nickName: json['NickName'] as String?,
    purpose: json['Purpose'] as String?,
    purposeDetails: json['PurposeDetails'] as String?,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$UpdateBeneficiaryRequestToJson(
        UpdateBeneficiaryRequest instance) =>
    <String, dynamic>{
      'BeneficiaryID': instance.beneficiaryId,
      'NickName': instance.nickName,
      'Purpose': instance.purpose,
      'PurposeDetails': instance.purposeDetails,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
