// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_residence_information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveResidenceInformationRequest _$SaveResidenceInformationRequestFromJson(
    Map<String, dynamic> json) {
  return SaveResidenceInformationRequest(
    residantCountry: json['residantCountry'] as String?,
    homeAddress: json['homeAddress'] as String?,
    streetAddress: json['streetAddress'] as String?,
    permanentResidantCountry: json['perResidantCountry'] as String?,
    permanentHomeAddre: json['perHomeAddre'] as String?,
    permanentStreetAddress: json['perStreetAddress'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SaveResidenceInformationRequestToJson(
        SaveResidenceInformationRequest instance) =>
    <String, dynamic>{
      'residantCountry': instance.residantCountry,
      'homeAddress': instance.homeAddress,
      'streetAddress': instance.streetAddress,
      'perResidantCountry': instance.permanentResidantCountry,
      'perHomeAddre': instance.permanentHomeAddre,
      'perStreetAddress': instance.permanentStreetAddress,
      'baseClass': instance.baseData,
    };
