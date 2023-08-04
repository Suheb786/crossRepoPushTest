// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountContentEntity _$CreateAccountContentEntityFromJson(
        Map<String, dynamic> json) =>
    CreateAccountContentEntity(
      data: json['data'] == null
          ? null
          : CreateAccountDataEntity.fromJson(
              json['data'] as Map<String, dynamic>),
      isAccountBlackListed: json['isAccountBlackListed'] as bool?,
    );

Map<String, dynamic> _$CreateAccountContentEntityToJson(
        CreateAccountContentEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isAccountBlackListed': instance.isAccountBlackListed,
    };
