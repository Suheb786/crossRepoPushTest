// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBeneficiaryRequest _$DeleteBeneficiaryRequestFromJson(
    Map<String, dynamic> json) {
  return DeleteBeneficiaryRequest(
    beneficiaryId: json['BeneficiaryID'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$DeleteBeneficiaryRequestToJson(
        DeleteBeneficiaryRequest instance) =>
    <String, dynamic>{
      'BeneficiaryID': instance.beneficiaryId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
