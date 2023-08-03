// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_fatca_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalFatcaDataEntity _$AdditionalFatcaDataEntityFromJson(Map<String, dynamic> json) =>
    AdditionalFatcaDataEntity(
      label: json['label'] as String?,
      type: json['type'] as String?,
      dropDownValues: (json['dropDownValues'] as List<dynamic>?)
          ?.map((e) => AdditionalDropDownDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      labelAr: json['labelAr'] as String?,
    );

Map<String, dynamic> _$AdditionalFatcaDataEntityToJson(AdditionalFatcaDataEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'labelAr': instance.labelAr,
      'type': instance.type,
      'dropDownValues': instance.dropDownValues,
    };
