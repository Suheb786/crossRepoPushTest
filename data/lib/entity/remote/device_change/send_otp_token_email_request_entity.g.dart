// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_token_email_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpTokenEmailRequestEntity _$SendOtpTokenEmailRequestEntityFromJson(Map<String, dynamic> json) {
  return SendOtpTokenEmailRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$SendOtpTokenEmailRequestEntityToJson(SendOtpTokenEmailRequestEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
