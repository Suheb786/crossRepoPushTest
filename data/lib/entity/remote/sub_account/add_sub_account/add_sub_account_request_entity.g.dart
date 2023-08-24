// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sub_account_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSubAccountRequestEntity _$AddSubAccountRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddSubAccountRequestEntity(
      nickName: json['NickName'] as String?,
      subAccountNo: json['SubAccountNo'] as String?,
      getToken: json['GetToken'] as bool?,
      baseClass: json['BaseClass'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AddSubAccountRequestEntityToJson(
        AddSubAccountRequestEntity instance) =>
    <String, dynamic>{
      'NickName': instance.nickName,
      'SubAccountNo': instance.subAccountNo,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
