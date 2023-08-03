// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_beneficiary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBeneficiaryRequest _$UpdateBeneficiaryRequestFromJson(Map<String, dynamic> json) =>
    UpdateBeneficiaryRequest(
      beneficiaryId: json['BeneficiaryDetailId'] as String,
      nickName: json['NickName'] as String?,
      isFromMobile: json['IsFromMobile'] as bool? ?? true,
      beneType: json['BeneType'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateBeneficiaryRequestToJson(UpdateBeneficiaryRequest instance) => <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryId,
      'NickName': instance.nickName,
      'IsFromMobile': instance.isFromMobile,
      'BeneType': instance.beneType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
