// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserEmailRequest _$CheckUserEmailRequestFromJson(
    Map<String, dynamic> json) {
  return CheckUserEmailRequest(
    email: json['userName'] as String?,
    channelId: json['channelId'] as String?,
    uniqueId: json['uniqueId'] as String?,
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckUserEmailRequestToJson(
        CheckUserEmailRequest instance) =>
    <String, dynamic>{
      'userName': instance.email,
      'channelId': instance.channelId,
      'uniqueId': instance.uniqueId,
      'baseClass': instance.baseData,
    };
