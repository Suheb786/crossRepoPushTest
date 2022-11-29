// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspend_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuspendCliqIdRequestEntity _$SuspendCliqIdRequestEntityFromJson(Map<String, dynamic> json) {
  return SuspendCliqIdRequestEntity(
    aliasId: json['aliasId'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SuspendCliqIdRequestEntityToJson(SuspendCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
