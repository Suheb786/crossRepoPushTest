// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserEmailRequest _$CheckUserEmailRequestFromJson(Map<String, dynamic> json) => CheckUserEmailRequest(
      channelId: json['channelId'] as String? ?? "01",
      content: json['content'] as Map<String, dynamic>?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CheckUserEmailRequestToJson(CheckUserEmailRequest instance) => <String, dynamic>{
      'channelId': instance.channelId,
      'content': instance.content,
      'baseClass': instance.baseData,
    };
