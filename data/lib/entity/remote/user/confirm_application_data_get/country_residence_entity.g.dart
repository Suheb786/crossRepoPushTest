// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_residence_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResidenceEntity _$CountryResidenceEntityFromJson(
    Map<String, dynamic> json) {
  return CountryResidenceEntity(
    id: json['id'] as int?,
    userId: json['userId'] as String?,
    residantCountry: json['residantCountry'] as String?,
    cityID: json['cityID'] as String?,
    stateID: json['stateID'] as String?,
    perCity: json['perCity'],
    city: json['city'] as String?,
    perResidantCountry: json['perCountry'] as String?,
    area: json['area'] as String?,
    buildingName: json['buildingName'] as String?,
    streetName: json['streetName'] as String?,
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    isActive: json['isActive'] as bool?,
    residentCountryName: json['residantCountryName'] as String?,
    perResidentCountryName: json['perCountryName'] as String?,
    perResidentCityName: json['perCityName'] as String?,
  );
}

Map<String, dynamic> _$CountryResidenceEntityToJson(
        CountryResidenceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'residantCountry': instance.residantCountry,
      'cityID': instance.cityID,
      'stateID': instance.stateID,
      'buildingName': instance.buildingName,
      'streetName': instance.streetName,
      'area': instance.area,
      'city': instance.city,
      'perCountry': instance.perResidantCountry,
      'perCity': instance.perCity,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
      'residantCountryName': instance.residentCountryName,
      'perCountryName': instance.perResidentCountryName,
      'perCityName': instance.perResidentCityName,
    };
