// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enable_finger_print_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnableFingerPrintRequestEntity _$EnableFingerPrintRequestEntityFromJson(
    Map<String, dynamic> json) {
  return EnableFingerPrintRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
    cipher: json['Cipher'] as String?,
  );
}

Map<String, dynamic> _$EnableFingerPrintRequestEntityToJson(
        EnableFingerPrintRequestEntity instance) =>
    <String, dynamic>{
      'Cipher': instance.cipher,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
