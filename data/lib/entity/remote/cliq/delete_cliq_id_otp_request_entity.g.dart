// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_cliq_id_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCliqIdOtpRequestEntity _$DeleteCliqIdOtpRequestEntityFromJson(
        Map<String, dynamic> json) =>
    DeleteCliqIdOtpRequestEntity(
      aliasId: json['aliasId'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeleteCliqIdOtpRequestEntityToJson(
        DeleteCliqIdOtpRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
