// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_combo_values_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetComboValuesContentEntity _$GetComboValuesContentEntityFromJson(Map<String, dynamic> json) {
  return GetComboValuesContentEntity(
    contentData: json['data'] == null
        ? null
        : GetComboValuesContentDataEntity.fromJson(json['data'] as Map<String, dynamic>),
    token: json['token'] as String?,
  );
}

Map<String, dynamic> _$GetComboValuesContentEntityToJson(GetComboValuesContentEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'data': instance.contentData,
    };
