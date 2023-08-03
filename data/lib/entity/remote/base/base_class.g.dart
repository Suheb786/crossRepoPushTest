// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseClassEntity _$BaseClassEntityFromJson(Map<String, dynamic> json) => BaseClassEntity(
      ip: json['IP'] as String?,
      deviceID: json['DeviceID'] as String?,
      channelType: json['ChannelType'],
      latitude: json['Latitude'] as String? ?? "0.0",
      longitude: json['Longitude'] as String? ?? "0.0",
      platform: json['Platform'],
      browser: json['Browser'] as String?,
      mobileModel: json['MobileModel'] as String?,
      appVersion: json['AppVersion'] as String?,
      vKeySessionId: json['VkeySessionId'] as String? ?? "",
    );

Map<String, dynamic> _$BaseClassEntityToJson(BaseClassEntity instance) => <String, dynamic>{
      'IP': instance.ip,
      'DeviceID': instance.deviceID,
      'ChannelType': instance.channelType,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'Platform': instance.platform,
      'Browser': instance.browser,
      'MobileModel': instance.mobileModel,
      'AppVersion': instance.appVersion,
      'VkeySessionId': instance.vKeySessionId,
    };
