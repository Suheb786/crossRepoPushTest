// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_RTP_request_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnRTPRequestOTPResponseEntity _$ReturnRTPRequestOTPResponseEntityFromJson(
    Map<String, dynamic> json) {
  return ReturnRTPRequestOTPResponseEntity(
    mobileCode: json['mobileCode'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
  );
}

Map<String, dynamic> _$ReturnRTPRequestOTPResponseEntityToJson(
        ReturnRTPRequestOTPResponseEntity instance) =>
    <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
