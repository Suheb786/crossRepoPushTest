// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountRequestEntity _$GetAccountRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetAccountRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetAccountRequestEntityToJson(
        GetAccountRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
