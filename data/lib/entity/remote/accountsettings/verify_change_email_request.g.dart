// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_change_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyChangeEmailRequest _$VerifyChangeEmailRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyChangeEmailRequest(
      uniqueId: json['UniqueId'] as String? ?? "",
      otp: json['Otp'] as String? ?? "",
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$VerifyChangeEmailRequestToJson(
        VerifyChangeEmailRequest instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'Otp': instance.otp,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
