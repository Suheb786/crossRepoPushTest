// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_videocall_status_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVideoCallStatusRequestEntity _$CheckVideoCallStatusRequestEntityFromJson(
    Map<String, dynamic> json) {
  return CheckVideoCallStatusRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$CheckVideoCallStatusRequestEntityToJson(
    CheckVideoCallStatusRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
