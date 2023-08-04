// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCliqIdRequestEntity _$DeleteCliqIdRequestEntityFromJson(
        Map<String, dynamic> json) =>
    DeleteCliqIdRequestEntity(
      aliasId: json['aliasId'] as String?,
      otpCode: json['OtpCode'] as String?,
      getToken: json['GetToken'] as bool?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeleteCliqIdRequestEntityToJson(
        DeleteCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'OtpCode': instance.otpCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
