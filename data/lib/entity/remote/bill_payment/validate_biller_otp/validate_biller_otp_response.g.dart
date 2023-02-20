// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_biller_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateBillerOtpResponse _$ValidateBillerOtpResponseFromJson(
    Map<String, dynamic> json) {
  return ValidateBillerOtpResponse(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidateBillerOtpResponseToJson(
        ValidateBillerOtpResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
