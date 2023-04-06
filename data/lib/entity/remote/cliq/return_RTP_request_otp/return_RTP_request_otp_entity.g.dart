// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_RTP_request_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnRTPRequestOTPEntity _$ReturnRTPRequestOTPEntityFromJson(
    Map<String, dynamic> json) {
  return ReturnRTPRequestOTPEntity(
    mobileCode: json['mobileCode'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
  );
}

Map<String, dynamic> _$ReturnRTPRequestOTPEntityToJson(
        ReturnRTPRequestOTPEntity instance) =>
    <String, dynamic>{
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
