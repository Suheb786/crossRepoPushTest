// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailOTPRequest _$SendEmailOTPRequestFromJson(Map<String, dynamic> json) =>
    SendEmailOTPRequest(
      email: json['Email'] as String?,
      password: json['Password'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SendEmailOTPRequestToJson(
        SendEmailOTPRequest instance) =>
    <String, dynamic>{
      'Email': instance.email,
      'Password': instance.password,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
