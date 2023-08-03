// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountContentEntity _$GetAccountContentEntityFromJson(
        Map<String, dynamic> json) =>
    GetAccountContentEntity(
      account: json['account'] == null
          ? null
          : AccountDetailsEntity.fromJson(
              json['account'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerDetailsEntity.fromJson(
              json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAccountContentEntityToJson(
        GetAccountContentEntity instance) =>
    <String, dynamic>{
      'account': instance.account,
      'customer': instance.customer,
    };
