// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeEmailRequest _$ChangeEmailRequestFromJson(Map<String, dynamic> json) {
  return ChangeEmailRequest(
    email: json['EmailId'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ChangeEmailRequestToJson(ChangeEmailRequest instance) => <String, dynamic>{
      'EmailId': instance.email,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
