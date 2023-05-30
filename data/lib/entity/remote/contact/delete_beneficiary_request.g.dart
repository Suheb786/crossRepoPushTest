// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBeneficiaryRequest _$DeleteBeneficiaryRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteBeneficiaryRequest(
      beneficiaryId: json['BeneficiaryDetailId'] as String,
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeleteBeneficiaryRequestToJson(
        DeleteBeneficiaryRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryId,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
