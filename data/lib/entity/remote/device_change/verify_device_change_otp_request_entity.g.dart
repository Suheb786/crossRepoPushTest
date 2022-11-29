// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_device_change_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyDeviceChangeOtpRequestEntity _$VerifyDeviceChangeOtpRequestEntityFromJson(Map<String, dynamic> json) {
  return VerifyDeviceChangeOtpRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    type: json['type'] as String?,
    otp: json['otp'] as String?,
    fireBaseToken: json['FireBaseToken'] as String?,
  );
}

Map<String, dynamic> _$VerifyDeviceChangeOtpRequestEntityToJson(
        VerifyDeviceChangeOtpRequestEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'getToken': instance.getToken,
      'FireBaseToken': instance.fireBaseToken,
      'otp': instance.otp,
      'baseClass': instance.baseData,
    };
