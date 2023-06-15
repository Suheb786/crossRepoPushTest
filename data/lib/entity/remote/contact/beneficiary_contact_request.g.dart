// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryContactRequest _$BeneficiaryContactRequestFromJson(Map<String, dynamic> json) =>
    BeneficiaryContactRequest(
      isFromMobile: json['IsFromMobile'] as bool,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BeneficiaryContactRequestToJson(BeneficiaryContactRequest instance) =>
    <String, dynamic>{
      'IsFromMobile': instance.isFromMobile,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
