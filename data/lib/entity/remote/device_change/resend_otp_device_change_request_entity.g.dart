// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp_device_change_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendOtpDeviceChangeRequestEntity _$ResendOtpDeviceChangeRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ResendOtpDeviceChangeRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      type: json['type'] as String? ?? "DeviceChange",
    );

Map<String, dynamic> _$ResendOtpDeviceChangeRequestEntityToJson(
        ResendOtpDeviceChangeRequestEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
