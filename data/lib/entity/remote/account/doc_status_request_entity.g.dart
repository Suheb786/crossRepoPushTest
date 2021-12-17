// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocStatusRequestEntity _$DocStatusRequestEntityFromJson(
    Map<String, dynamic> json) {
  return DocStatusRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$DocStatusRequestEntityToJson(
        DocStatusRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
