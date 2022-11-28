// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_combo_values_content_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetComboValuesContentDataEntity _$GetComboValuesContentDataEntityFromJson(Map<String, dynamic> json) {
  return GetComboValuesContentDataEntity(
    employmentStatus: (json['EmploymentStatus'] as List<dynamic>?)
        ?.map((e) => GetComboValuesDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    businessType: (json['BusinessType'] as List<dynamic>?)
        ?.map((e) => GetComboValuesDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    natureOfSpecialNeed: (json['NatureOfSpecialNeed'] as List<dynamic>?)
        ?.map((e) => GetComboValuesDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GetComboValuesContentDataEntityToJson(GetComboValuesContentDataEntity instance) =>
    <String, dynamic>{
      'EmploymentStatus': instance.employmentStatus,
      'NatureOfSpecialNeed': instance.natureOfSpecialNeed,
      'BusinessType': instance.businessType,
    };
