// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cipher_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCipherRequestEntity _$GetCipherRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetCipherRequestEntity(
    deviceId: json['deviceid'] as String?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
    userId: json['userid'] as String?,
  );
}

Map<String, dynamic> _$GetCipherRequestEntityToJson(
        GetCipherRequestEntity instance) =>
    <String, dynamic>{
      'deviceid': instance.deviceId,
      'userid': instance.userId,
      'BaseClass': instance.baseData,
    };
