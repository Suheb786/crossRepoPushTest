// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disable_finger_print_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisableFingerPrintRequestEntity _$DisableFingerPrintRequestEntityFromJson(
    Map<String, dynamic> json) {
  return DisableFingerPrintRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
    uniqueId: json['UniqueId'] as String?,
  );
}

Map<String, dynamic> _$DisableFingerPrintRequestEntityToJson(
        DisableFingerPrintRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
