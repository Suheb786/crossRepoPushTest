// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_token_device_change_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpTokenDeviceChangeRequestEntity
    _$SendOtpTokenDeviceChangeRequestEntityFromJson(
            Map<String, dynamic> json) =>
        SendOtpTokenDeviceChangeRequestEntity(
          baseData: json['baseClass'] as Map<String, dynamic>,
          getToken: json['getToken'] as bool? ?? true,
          type: json['type'] as String? ?? "DeviceChange",
          otp: json['otp'] as String? ?? "",
        );

Map<String, dynamic> _$SendOtpTokenDeviceChangeRequestEntityToJson(
        SendOtpTokenDeviceChangeRequestEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'getToken': instance.getToken,
      'otp': instance.otp,
      'baseClass': instance.baseData,
    };
