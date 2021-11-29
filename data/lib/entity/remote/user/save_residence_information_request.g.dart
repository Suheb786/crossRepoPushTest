// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_residence_information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveResidenceInformationRequest _$SaveResidenceInformationRequestFromJson(
    Map<String, dynamic> json) {
  return SaveResidenceInformationRequest(
    residantCountry: json['residantCountry'] as String?,
    buildingName: json['BuildingName'] as String?,
    streetName: json['StreetName'] as String?,
    district: json['District'] as String?,
    city: json['City'] as String?,
    perCountry: json['PerCountry'] as String?,
    perCity: json['PerCity'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SaveResidenceInformationRequestToJson(
        SaveResidenceInformationRequest instance) =>
    <String, dynamic>{
      'residantCountry': instance.residantCountry,
      'BuildingName': instance.buildingName,
      'StreetName': instance.streetName,
      'District': instance.district,
      'City': instance.city,
      'PerCountry': instance.perCountry,
      'PerCity': instance.perCity,
      'baseClass': instance.baseData,
    };
