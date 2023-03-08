// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_cliq_id_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspendCliqIdOtpRequestEntity _$SuspendCliqIdOtpRequestEntityFromJson(Map<String, dynamic> json) {
  return SuspendCliqIdOtpRequestEntity(
    aliasId: json['aliasId'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SuspendCliqIdOtpRequestEntityToJson(SuspendCliqIdOtpRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
