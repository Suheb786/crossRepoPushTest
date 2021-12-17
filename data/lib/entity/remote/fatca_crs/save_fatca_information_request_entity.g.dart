// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_fatca_information_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveFatcaInformationRequestEntity _$SaveFatcaInformationRequestEntityFromJson(
    Map<String, dynamic> json) {
  return SaveFatcaInformationRequestEntity(
    response1: json['Response1'] as bool?,
    response2: json['Response2'] as bool?,
    response3: json['Response3'] as bool?,
    response4: json['Response4'] as bool?,
    response5: json['Response5'] as bool?,
    isTinNoRes4: json['IsTinNoRes4'] as bool?,
    taxResidenceCountry: json['TaxResidenceCountry'] as String?,
    tinNoRes4: json['TinNoRes4'] as String?,
    reasonUnavailableRes4: json['ReasonUnavailbleRes4'] as String?,
    reasonBRes4: json['ReasonBRes4'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
    relationshipWithPEP: json['RelationshipWithPEP'] as String?,
    personName: json['PersonName'] as String?,
    personRole: json['PersonRole'] as String?,
    getToken: json['GetToken'] as bool?,
  );
}

Map<String, dynamic> _$SaveFatcaInformationRequestEntityToJson(
        SaveFatcaInformationRequestEntity instance) =>
    <String, dynamic>{
      'Response1': instance.response1,
      'Response2': instance.response2,
      'Response3': instance.response3,
      'Response4': instance.response4,
      'Response5': instance.response5,
      'RelationshipWithPEP': instance.relationshipWithPEP,
      'PersonName': instance.personName,
      'PersonRole': instance.personRole,
      'IsTinNoRes4': instance.isTinNoRes4,
      'TaxResidenceCountry': instance.taxResidenceCountry,
      'TinNoRes4': instance.tinNoRes4,
      'ReasonUnavailbleRes4': instance.reasonUnavailableRes4,
      'ReasonBRes4': instance.reasonBRes4,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
