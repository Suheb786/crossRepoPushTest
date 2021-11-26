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
    homeAddress: json['homeAddress'] as String?,
    streetAddress: json['streetAddress'] as String?,
    perResidantCountry: json['perResidantCountry'] as String?,
    perHomeAddress: json['perHomeAddress'],
    perStreetAddress: json['perStreetAddress'],
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    isActive: json['isActive'] as bool?,
  );
}

Map<String, dynamic> _$CountryResidenceEntityToJson(
        CountryResidenceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'residantCountry': instance.residantCountry,
      'homeAddress': instance.homeAddress,
      'streetAddress': instance.streetAddress,
      'perResidantCountry': instance.perResidantCountry,
      'perHomeAddress': instance.perHomeAddress,
      'perStreetAddress': instance.perStreetAddress,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
    };
