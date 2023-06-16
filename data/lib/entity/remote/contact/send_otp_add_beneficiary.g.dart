// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_add_beneficiary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOTPAddBeneficiaryRequest _$SendOTPAddBeneficiaryRequestFromJson(
        Map<String, dynamic> json) =>
    SendOTPAddBeneficiaryRequest(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SendOTPAddBeneficiaryRequestToJson(
        SendOTPAddBeneficiaryRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
