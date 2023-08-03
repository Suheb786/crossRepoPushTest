// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCodeEntity _$CountryCodeEntityFromJson(Map<String, dynamic> json) =>
    CountryCodeEntity(
      isoCode3: json['isoCode3'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      isoCode: json['isoCode'] as String? ?? '',
      phoneCode: json['phoneCode'] as String? ?? '',
      countryName: json['countryName'] as String? ?? '',
      isAllowedCountry: json['isAllowedCountry'] as bool? ?? false,
      nationality: json['nationality'] as String? ?? '',
      gfxCode: json['gfxCode'] as String? ?? '',
      gfxIntCode: json['gfxIntCode'] as String? ?? '',
      isRestrictedNationality:
          json['isRestrictedNationality'] as bool? ?? false,
      isGccCountry: json['isGccCountry'] as bool? ?? false,
      isMobileAllowed: json['isMobileAllowed'] as bool? ?? false,
      crossAllowed: json['crossAllowed'] as bool? ?? false,
      crossIdAllowed: json['crossIdAllowed'] as bool? ?? false,
      mobileMax: json['mobileMax'] as int? ?? 0,
      mobileMin: json['mobileMin'] as int? ?? 0,
      idForensic: json['idForensic'] as bool? ?? false,
      passportScan: json['passportScan'] as bool? ?? false,
      isAllowedFatca: json['isAllowedFatca'] as bool? ?? false,
      isNationalityAllowed: json['isNationalityAllowed'] as bool? ?? false,
      isIssuerAllowed: json['isIssuerAllowed'] as bool? ?? false,
      countryNameAR: json['countryNameAR'] as String? ?? '',
    );

Map<String, dynamic> _$CountryCodeEntityToJson(CountryCodeEntity instance) =>
    <String, dynamic>{
      'isoCode3': instance.isoCode3,
      'score': instance.score,
      'isoCode': instance.isoCode,
      'phoneCode': instance.phoneCode,
      'countryName': instance.countryName,
      'isAllowedCountry': instance.isAllowedCountry,
      'nationality': instance.nationality,
      'gfxCode': instance.gfxCode,
      'gfxIntCode': instance.gfxIntCode,
      'isRestrictedNationality': instance.isRestrictedNationality,
      'isGccCountry': instance.isGccCountry,
      'isMobileAllowed': instance.isMobileAllowed,
      'crossAllowed': instance.crossAllowed,
      'crossIdAllowed': instance.crossIdAllowed,
      'mobileMax': instance.mobileMax,
      'mobileMin': instance.mobileMin,
      'idForensic': instance.idForensic,
      'passportScan': instance.passportScan,
      'isAllowedFatca': instance.isAllowedFatca,
      'isNationalityAllowed': instance.isNationalityAllowed,
      'isIssuerAllowed': instance.isIssuerAllowed,
      'countryNameAR': instance.countryNameAR,
    };
