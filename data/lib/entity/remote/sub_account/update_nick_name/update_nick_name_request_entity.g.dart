// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_nick_name_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNickNameSubAccountRequestEntity
    _$UpdateNickNameSubAccountRequestEntityFromJson(
            Map<String, dynamic> json) =>
        UpdateNickNameSubAccountRequestEntity(
          nickName: json['NickName'] as String,
          accountNo: json['accountNo'] as String,
          getToken: json['GetToken'] as bool,
          baseClass: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$UpdateNickNameSubAccountRequestEntityToJson(
        UpdateNickNameSubAccountRequestEntity instance) =>
    <String, dynamic>{
      'NickName': instance.nickName,
      'accountNo': instance.accountNo,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
