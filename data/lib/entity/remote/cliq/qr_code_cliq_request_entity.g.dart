// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_cliq_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeCliqRequestEntity _$QrCodeCliqRequestEntityFromJson(Map<String, dynamic> json) {
  return QrCodeCliqRequestEntity(
    code: json['code'] as String?,
    getToken: json['getToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$QrCodeCliqRequestEntityToJson(QrCodeCliqRequestEntity instance) => <String, dynamic>{
      'code': instance.code,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
