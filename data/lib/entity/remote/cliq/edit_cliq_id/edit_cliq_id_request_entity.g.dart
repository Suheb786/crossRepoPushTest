// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditCliqIdRequestEntity _$EditCliqIdRequestEntityFromJson(
        Map<String, dynamic> json) =>
    EditCliqIdRequestEntity(
      isAlias: json['isAlias'] as bool?,
      aliasValue: json['aliasValue'] as String?,
      aliasId: json['aliasId'] as String?,
      getToken: json['getToken'] as bool?,
      OtpCode: json['OtpCode'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$EditCliqIdRequestEntityToJson(
        EditCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'isAlias': instance.isAlias,
      'aliasId': instance.aliasId,
      'aliasValue': instance.aliasValue,
      'OtpCode': instance.OtpCode,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
