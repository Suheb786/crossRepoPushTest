// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_country_residence_info_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveCountryResidenceInfoResponseEntity _$SaveCountryResidenceInfoResponseEntityFromJson(
        Map<String, dynamic> json) =>
    SaveCountryResidenceInfoResponseEntity(
      saveCountryResidenceInfoResponseDataEntity: json['response'] == null
          ? null
          : SaveCountryResidenceInfoResponseDataEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveCountryResidenceInfoResponseEntityToJson(
        SaveCountryResidenceInfoResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.saveCountryResidenceInfoResponseDataEntity,
    };
