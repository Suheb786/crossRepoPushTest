import 'package:json_annotation/json_annotation.dart';

part "set_fatca_w8_request_entity.g.dart";

@JsonSerializable()
class SetFatcaW8RequestEntity {
  ///name on tax
  @JsonKey(name: "NameIncomeTAXReturn")
  final String? nameIncomeTAXReturn;
  @JsonKey(name: "DateOfBirth")
  final String? dateOfBirth;
  @JsonKey(name: "CitizenShipCountry")
  final String? citizenShipCountry;

  ///permanent address
  @JsonKey(name: "PermenantResidenceAddress")
  final String? permanentResidenceAddress;
  @JsonKey(name: "Country")
  final String? countryIsoCode;
  @JsonKey(name: "City")
  final String? cityId;
  @JsonKey(name: "State")
  final String? stateId;
  @JsonKey(name: "PostCode")
  final String? postCode;

  ///different mailing address
  @JsonKey(name: "DifferentMailingAddress")
  final bool? isDifferentMailingAddress;
  @JsonKey(name: "MailingAddressLine")
  final String? mailingAddressLine;
  @JsonKey(name: "DifferentMailingCountry")
  final String? differentMailingCountryIsoCode;
  @JsonKey(name: "DifferentMailingState")
  final String? differentMailingStateID;
  @JsonKey(name: "DifferentMailingCity")
  final String? differentMailingCityId;
  @JsonKey(name: "DifferentMailingPostCode")
  final String? differentMailingPostCode;

  ///tax payer details
  @JsonKey(name: "TaxPayer")
  final String? taxPayer;
  @JsonKey(name: "UsTaxPayerTin")
  final String? usTaxPayerTin;
  @JsonKey(name: "ForeignTaxPayerTin")
  final String? foreignTaxPayerTin;
  @JsonKey(name: "ReferenceNumber")
  final String? referenceNumber;

  ///tax treaty benefits
  @JsonKey(name: "ClaimTaxTreatBenefits")
  final bool? isClaimedTaxTreatBenefits;
  @JsonKey(name: "BeneficialOwnerResident")
  final String? beneficialOwnerResidentIsoCode;
  @JsonKey(name: "ProvisionOrClaim")
  final String? provisionOrClaim;
  @JsonKey(name: "TreatyClaimRate")
  final String? treatyClaimRate;
  @JsonKey(name: "TypeOfIncome")
  final String? typeOfIncome;
  @JsonKey(name: "Explanation")
  final String? explanation;
  @JsonKey(name: "SignatureId")
  final String? signatureId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  SetFatcaW8RequestEntity(
      {this.nameIncomeTAXReturn,
      this.dateOfBirth,
      this.citizenShipCountry,
      this.permanentResidenceAddress,
      this.countryIsoCode,
      this.cityId,
      this.stateId,
      this.postCode,
      this.isDifferentMailingAddress,
      this.mailingAddressLine,
      this.differentMailingCountryIsoCode,
      this.differentMailingStateID,
      this.differentMailingCityId,
      this.differentMailingPostCode,
      this.taxPayer,
      this.usTaxPayerTin,
      this.foreignTaxPayerTin,
      this.referenceNumber,
      this.isClaimedTaxTreatBenefits,
      this.beneficialOwnerResidentIsoCode,
      this.provisionOrClaim,
      this.treatyClaimRate,
      this.typeOfIncome,
      this.explanation,
      this.signatureId,
      this.getToken,
      this.baseData});

  factory SetFatcaW8RequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SetFatcaW8RequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SetFatcaW8RequestEntityToJson(this);
}
