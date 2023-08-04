// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_activate_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReActivateCliqIdRequestEntity _$ReActivateCliqIdRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ReActivateCliqIdRequestEntity(
      aliasId: json['aliasId'] as String?,
      otpCode: json['OtpCode'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ReActivateCliqIdRequestEntityToJson(
        ReActivateCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
