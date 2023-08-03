// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutRequestEntity _$LogoutRequestEntityFromJson(Map<String, dynamic> json) => LogoutRequestEntity(
      appVersion: json['AppVersion'] as String?,
      mobileModel: json['MobileModel'] as String?,
      browser: json['Browser'] as String?,
      platform: json['Platform'] as String?,
      longitude: json['Longitude'] as String?,
      latitude: json['Latitude'] as String?,
      deviceID: json['DeviceID'] as String?,
      vkeySessionId: json['VkeySessionId'] as String?,
      channelType: json['ChannelType'] as String?,
      iP: json['IP'] as String?,
    );

Map<String, dynamic> _$LogoutRequestEntityToJson(LogoutRequestEntity instance) => <String, dynamic>{
      'IP': instance.iP,
      'DeviceID': instance.deviceID,
      'ChannelType': instance.channelType,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'Platform': instance.platform,
      'Browser': instance.browser,
      'VkeySessionId': instance.vkeySessionId,
      'MobileModel': instance.mobileModel,
      'AppVersion': instance.appVersion,
    };
