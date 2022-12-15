// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_fatca_w8_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFatcaW8RequestEntity _$SetFatcaW8RequestEntityFromJson(
    Map<String, dynamic> json) {
  return SetFatcaW8RequestEntity(
    nameIncomeTAXReturn: json['NameIncomeTAXReturn'] as String?,
    dateOfBirth: json['DateOfBirth'] as String?,
    citizenShipCountry: json['CitizenShipCountry'] as String?,
    permanentResidenceAddress: json['PermenantResidenceAddress'] as String?,
    countryIsoCode: json['Country'] as String?,
    cityId: json['City'] as String?,
    stateId: json['State'] as String?,
    postCode: json['PostCode'] as String?,
    isDifferentMailingAddress: json['DifferentMailingAddress'] as bool?,
    mailingAddressLine: json['MailingAddressLine'] as String?,
    differentMailingCountryIsoCode: json['DifferentMailingCountry'] as String?,
    differentMailingStateID: json['DifferentMailingState'] as String?,
    differentMailingCityId: json['DifferentMailingCity'] as String?,
    differentMailingPostCode: json['DifferentMailingPostCode'] as String?,
    taxPayer: json['TaxPayer'] as String?,
    usTaxPayerTin: json['UsTaxPayerTin'] as String?,
    foreignTaxPayerTin: json['ForeignTaxPayerTin'] as String?,
    referenceNumber: json['ReferenceNumber'] as String?,
    isClaimedTaxTreatBenefits: json['ClaimTaxTreatBenefits'] as bool?,
    beneficialOwnerResidentIsoCode: json['BeneficialOwnerResident'] as String?,
    provisionOrClaim: json['ProvisionOrClaim'] as String?,
    treatyClaimRate: json['TreatyClaimRate'] as String?,
    typeOfIncome: json['TypeOfIncome'] as String?,
    explanation: json['Explanation'] as String?,
    signatureId: json['SignatureId'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$SetFatcaW8RequestEntityToJson(
        SetFatcaW8RequestEntity instance) =>
    <String, dynamic>{
      'NameIncomeTAXReturn': instance.nameIncomeTAXReturn,
      'DateOfBirth': instance.dateOfBirth,
      'CitizenShipCountry': instance.citizenShipCountry,
      'PermenantResidenceAddress': instance.permanentResidenceAddress,
      'Country': instance.countryIsoCode,
      'City': instance.cityId,
      'State': instance.stateId,
      'PostCode': instance.postCode,
      'DifferentMailingAddress': instance.isDifferentMailingAddress,
      'MailingAddressLine': instance.mailingAddressLine,
      'DifferentMailingCountry': instance.differentMailingCountryIsoCode,
      'DifferentMailingState': instance.differentMailingStateID,
      'DifferentMailingCity': instance.differentMailingCityId,
      'DifferentMailingPostCode': instance.differentMailingPostCode,
      'TaxPayer': instance.taxPayer,
      'UsTaxPayerTin': instance.usTaxPayerTin,
      'ForeignTaxPayerTin': instance.foreignTaxPayerTin,
      'ReferenceNumber': instance.referenceNumber,
      'ClaimTaxTreatBenefits': instance.isClaimedTaxTreatBenefits,
      'BeneficialOwnerResident': instance.beneficialOwnerResidentIsoCode,
      'ProvisionOrClaim': instance.provisionOrClaim,
      'TreatyClaimRate': instance.treatyClaimRate,
      'TypeOfIncome': instance.typeOfIncome,
      'Explanation': instance.explanation,
      'SignatureId': instance.signatureId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
