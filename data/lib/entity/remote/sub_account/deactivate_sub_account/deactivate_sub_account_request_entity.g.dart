// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deactivate_sub_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeactivateSubAccountRequestEntity _$DeactivateSubAccountRequestEntityFromJson(
        Map<String, dynamic> json) =>
    DeactivateSubAccountRequestEntity(
      subAccountNo: json['SubAccountNo'] as String,
      getToken: json['GetToken'] as bool,
      baseClass: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DeactivateSubAccountRequestEntityToJson(
        DeactivateSubAccountRequestEntity instance) =>
    <String, dynamic>{
      'SubAccountNo': instance.subAccountNo,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
