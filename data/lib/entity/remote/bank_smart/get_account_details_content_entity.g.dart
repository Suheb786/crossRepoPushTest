// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_details_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountDetailsContentEntity _$GetAccountDetailsContentEntityFromJson(Map<String, dynamic> json) {
  return GetAccountDetailsContentEntity(
    data:
        json['data'] == null ? null : CreateAccountDataEntity.fromJson(json['data'] as Map<String, dynamic>),
    openDate: json['openDate'] as String?,
  );
}

Map<String, dynamic> _$GetAccountDetailsContentEntityToJson(GetAccountDetailsContentEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
      'openDate': instance.openDate,
    };
