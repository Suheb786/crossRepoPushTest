// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_fatca_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalFatcaDataEntity _$AdditionalFatcaDataEntityFromJson(
    Map<String, dynamic> json) {
  return AdditionalFatcaDataEntity(
    label: json['label'] as String?,
    type: json['type'] as String?,
    dropDownValues: (json['dropDownValues'] as List<dynamic>?)
        ?.map((e) =>
            AdditionalDropDownDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AdditionalFatcaDataEntityToJson(
        AdditionalFatcaDataEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'type': instance.type,
      'dropDownValues': instance.dropDownValues,
    };
