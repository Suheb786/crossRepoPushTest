// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_login_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndroidLoginRequestEntity _$AndroidLoginRequestEntityFromJson(
    Map<String, dynamic> json) {
  return AndroidLoginRequestEntity(
    uniqueId: json['uniqueId'] as String?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
    fireBaseToken: json['fireBaseToken'] as String?,
    signature: json['Signature'] as String?,
  );
}

Map<String, dynamic> _$AndroidLoginRequestEntityToJson(
        AndroidLoginRequestEntity instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'fireBaseToken': instance.fireBaseToken,
      'Signature': instance.signature,
      'BaseClass': instance.baseData,
    };
