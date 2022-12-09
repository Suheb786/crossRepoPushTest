// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_activate_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReActivateCliqIdRequestEntity _$ReActivateCliqIdRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ReActivateCliqIdRequestEntity(
    aliasId: json['aliasId'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ReActivateCliqIdRequestEntityToJson(
        ReActivateCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
