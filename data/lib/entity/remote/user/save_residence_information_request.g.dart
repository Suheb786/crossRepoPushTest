// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_residence_information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveResidenceInformationRequest _$SaveResidenceInformationRequestFromJson(Map<String, dynamic> json) {
  return SaveResidenceInformationRequest(
    residantCountry: json['residantCountry'] as String?,
    buildingName: json['BuildingName'] as String?,
    streetName: json['StreetName'] as String?,
    area: json['Area'] as String?,
    cityId: json['cityID'] as String?,
    stateID: json['stateID'] as String?,
    perCountry: json['PerCountry'] as String?,
    perCity: json['PerCity'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SaveResidenceInformationRequestToJson(SaveResidenceInformationRequest instance) =>
    <String, dynamic>{
      'residantCountry': instance.residantCountry,
      'BuildingName': instance.buildingName,
      'StreetName': instance.streetName,
      'Area': instance.area,
      'cityID': instance.cityId,
      'stateID': instance.stateID,
      'PerCountry': instance.perCountry,
      'PerCity': instance.perCity,
      'baseClass': instance.baseData,
    };
