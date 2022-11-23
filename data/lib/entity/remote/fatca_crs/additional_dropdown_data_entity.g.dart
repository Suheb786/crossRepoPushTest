// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_dropdown_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalDropDownDataEntity _$AdditionalDropDownDataEntityFromJson(Map<String, dynamic> json) {
  return AdditionalDropDownDataEntity(
    name: json['name'] as String?,
    values: json['values'] as String?,
    nameAR: json['nameAR'] as String?,
  );
}

Map<String, dynamic> _$AdditionalDropDownDataEntityToJson(AdditionalDropDownDataEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nameAR': instance.nameAR,
      'values': instance.values,
    };
