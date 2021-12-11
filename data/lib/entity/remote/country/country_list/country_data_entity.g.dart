// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDataEntity _$CountryDataEntityFromJson(Map<String, dynamic> json) {
  return CountryDataEntity(
    isoCode3: json['isoCode3'] as String?,
    isoCode: json['isoCode'] as String?,
    phoneCode: json['phoneCode'] as String?,
    countryName: json['countryName'] as String?,
    isAllowedCountry: json['isAllowedCountry'] as bool?,
    nationality: json['nationality'] as String?,
    gfxCode: json['gfxCode'] as String?,
    isRestrictedNationality: json['isRestrictedNationality'] as bool?,
    isMobileAllowed: json['isMobileAllowed'] as bool?,
    isNationalityAllowed: json['isNationalityAllowed'] as bool?,
    isIssuerAllowed: json['isIssuerAllowed'] as bool?,
    mobileMax: json['mobileMax'] as int?,
  );
}

Map<String, dynamic> _$CountryDataEntityToJson(CountryDataEntity instance) =>
    <String, dynamic>{
      'isoCode3': instance.isoCode3,
      'isoCode': instance.isoCode,
      'phoneCode': instance.phoneCode,
      'countryName': instance.countryName,
      'isAllowedCountry': instance.isAllowedCountry,
      'nationality': instance.nationality,
      'gfxCode': instance.gfxCode,
      'isRestrictedNationality': instance.isRestrictedNationality,
      'isMobileAllowed': instance.isMobileAllowed,
      'isNationalityAllowed': instance.isNationalityAllowed,
      'isIssuerAllowed': instance.isIssuerAllowed,
      'mobileMax': instance.mobileMax,
    };
