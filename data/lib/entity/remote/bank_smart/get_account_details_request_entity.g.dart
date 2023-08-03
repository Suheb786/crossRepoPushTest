// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_details_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountDetailsRequestEntity _$GetAccountDetailsRequestEntityFromJson(Map<String, dynamic> json) =>
    GetAccountDetailsRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      baseData: BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAccountDetailsRequestEntityToJson(GetAccountDetailsRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
