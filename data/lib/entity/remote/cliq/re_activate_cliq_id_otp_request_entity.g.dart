// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_activate_cliq_id_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReActivateCliqIdOtpRequestEntity _$ReActivateCliqIdOtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ReActivateCliqIdOtpRequestEntity(
      aliasId: json['aliasId'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ReActivateCliqIdOtpRequestEntityToJson(
        ReActivateCliqIdOtpRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
