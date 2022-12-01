// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_cliq_id_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCliqIdRequestEntity _$DeleteCliqIdRequestEntityFromJson(
    Map<String, dynamic> json) {
  return DeleteCliqIdRequestEntity(
    aliasId: json['aliasId'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$DeleteCliqIdRequestEntityToJson(
        DeleteCliqIdRequestEntity instance) =>
    <String, dynamic>{
      'aliasId': instance.aliasId,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
