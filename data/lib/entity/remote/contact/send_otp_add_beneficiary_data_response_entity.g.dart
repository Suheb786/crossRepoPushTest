// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_add_beneficiary_data_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpAddBeneficiaryDataResponseEntity _$SendOtpAddBeneficiaryDataResponseEntityFromJson(
        Map<String, dynamic> json) =>
    SendOtpAddBeneficiaryDataResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendOtpAddBeneficiaryDataResponseEntityToJson(
        SendOtpAddBeneficiaryDataResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
