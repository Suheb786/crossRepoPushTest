// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_residence_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResidenceEntity _$CountryResidenceEntityFromJson(
        Map<String, dynamic> json) =>
    CountryResidenceEntity(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      residantCountry: json['residantCountry'] as String?,
      cityID: json['cityID'] as String?,
      stateID: json['stateID'] as String?,
      perCity: json['perCity'],
      city: json['city'] as String?,
      cityAr: json['cityAr'] as String?,
      perResidantCountry: json['perCountry'] as String?,
      area: json['area'] as String?,
      buildingName: json['buildingName'] as String?,
      streetName: json['streetName'] as String?,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      isActive: json['isActive'] as bool?,
      residentCountryName: json['residantCountryName'] as String? ?? "",
      residentCountryNameAr: json['residantCountryNameAr'] as String? ?? '',
      perResidentCountryName: json['perCountryName'] as String? ?? "",
      perResidentCountryNameAr: json['perCountryNameAr'] as String? ?? '',
      perResidentCityName: json['perCityName'] as String? ?? "",
      perResidentCityNameAr: json['perCityNameAr'] as String? ?? '',
    );

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
      'cityAr': instance.cityAr,
      'perCountry': instance.perResidantCountry,
      'perCity': instance.perCity,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
      'residantCountryName': instance.residentCountryName,
      'residantCountryNameAr': instance.residentCountryNameAr,
      'perCountryName': instance.perResidentCountryName,
      'perCountryNameAr': instance.perResidentCountryNameAr,
      'perCityName': instance.perResidentCityName,
      'perCityNameAr': instance.perResidentCityNameAr,
    };
