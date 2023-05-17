// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetailRequest _$ContactDetailRequestFromJson(
        Map<String, dynamic> json) =>
    ContactDetailRequest(
      beneficiaryDetailId: json['BeneficiaryDetailId'] as String?,
      isFromMobile: json['IsFromMobile'] as bool?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ContactDetailRequestToJson(
        ContactDetailRequest instance) =>
    <String, dynamic>{
      'BeneficiaryDetailId': instance.beneficiaryDetailId,
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
