// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseClassEntity _$BaseClassEntityFromJson(Map<String, dynamic> json) {
  return BaseClassEntity(
    ip: json['ip'] as String?,
    deviceID: json['deviceID'] as String?,
    channelType: json['channelType'],
    latitude: json['latitude'] as String?,
    longitude: json['longitude'] as String?,
    platform: json['platform'],
    browser: json['browser'] as String?,
    mobileModel: json['mobileModel'] as String?,
    appVersion: json['appVersion'] as String?,
  );
}

Map<String, dynamic> _$BaseClassEntityToJson(BaseClassEntity instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'deviceID': instance.deviceID,
      'channelType': instance.channelType,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'platform': instance.platform,
      'browser': instance.browser,
      'mobileModel': instance.mobileModel,
      'appVersion': instance.appVersion,
    };
