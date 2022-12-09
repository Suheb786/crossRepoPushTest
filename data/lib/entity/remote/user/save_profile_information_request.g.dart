// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_profile_information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveProfileInformationRequest _$SaveProfileInformationRequestFromJson(
    Map<String, dynamic> json) {
  return SaveProfileInformationRequest(
    married: json['Married'] as bool?,
    specialPerson: json['SpecialPerson'] as bool?,
    employmentStatus: json['EmploymentStatus'] as String?,
    spauseName: json['SpauseName'] as String?,
    natureSP: json['NatureSP'] as String?,
    additionalNationality: json['AdditionalNationality'] as String?,
    isAdditionalNational: json['IsAdditionalNational'] as bool?,
    isEmployed: json['IsEmployed'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SaveProfileInformationRequestToJson(
        SaveProfileInformationRequest instance) =>
    <String, dynamic>{
      'Married': instance.married,
      'SpecialPerson': instance.specialPerson,
      'EmploymentStatus': instance.employmentStatus,
      'SpauseName': instance.spauseName,
      'NatureSP': instance.natureSP,
      'IsAdditionalNational': instance.isAdditionalNational,
      'IsEmployed': instance.isEmployed,
      'AdditionalNationality': instance.additionalNationality,
      'baseClass': instance.baseData,
    };
