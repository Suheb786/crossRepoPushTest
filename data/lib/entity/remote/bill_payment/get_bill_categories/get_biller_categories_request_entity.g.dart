// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_biller_categories_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillerCategoriesRequestEntity _$GetBillerCategoriesRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetBillerCategoriesRequestEntity(
    type: json['Type'] as String,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetBillerCategoriesRequestEntityToJson(
        GetBillerCategoriesRequestEntity instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
