// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspendCliqIdRequestEntity _$SuspendCliqIdRequestEntityFromJson(
    Map<String, dynamic> json) {
  return SuspendCliqIdRequestEntity(
    aliasId: json['aliasId'] as String?,
    otpCode: json['OtpCode'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SuspendCliqIdRequestEntityToJson(
        SuspendCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
