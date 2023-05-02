// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cipher_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCipherRequestEntity _$GetCipherRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetCipherRequestEntity(
      uniqueId: json['UniqueId'] as String?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetCipherRequestEntityToJson(
        GetCipherRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'BaseClass': instance.baseData,
    };
