// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_name_mobile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserNameMobileRequest _$CheckUserNameMobileRequestFromJson(
    Map<String, dynamic> json) {
  return CheckUserNameMobileRequest(
    channelId: json['channelId'] as String?,
    content: json['content'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$CheckUserNameMobileRequestToJson(
        CheckUserNameMobileRequest instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'content': instance.content,
    };
