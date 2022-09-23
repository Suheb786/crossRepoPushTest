import 'package:json_annotation/json_annotation.dart';

part "set_fatca_w9_request_entity.g.dart";

@JsonSerializable()
class SetFatcaW9RequestEntity {
  ///name on tax
  @JsonKey(name: "NamePerIncomeTaxReturn")
  final String? namePerIncomeTaxReturn;
  @JsonKey(name: "BusinessName")
  final String? businessName;

  ///us address
  @JsonKey(name: "USAddress")
  final String? uSAddress;
  @JsonKey(name: "CountryCode")
  final String? countryCode;
  @JsonKey(name: "State")
  final String? stateId;
  @JsonKey(name: "City")
  final String? cityId;
  @JsonKey(name: "PostCode")
  final String? postCode;
  @JsonKey(name: "AccountNumberList")
  final String? accountNumberList;
  @JsonKey(name: "ExemptPayeeCode")
  final String? exemptPayeeCode;
  @JsonKey(name: "ExemptFromFatcaReportingCode")
  final String? exemptFromFatcaReportingCode;

  ///additional requester
  @JsonKey(name: "AdditionalRequester")
  final bool? isAdditionalRequester;
  @JsonKey(name: "RequesterName")
  final String? requesterName;
  @JsonKey(name: "RequesterUSAddress")
  final String? requesterUSAddress;
  @JsonKey(name: "RequesterCountryCode")
  final String? requesterCountryCode;
  @JsonKey(name: "RequesterState")
  final String? requesterState;
  @JsonKey(name: "RequesterCity")
  final String? requesterCity;
  @JsonKey(name: "RequesterPostCode")
  final String? requesterPostCode;

  ///tax payer details
  @JsonKey(name: "TaxPayer")
  final String? taxPayer;
  @JsonKey(name: "SocialSecurityNumber")
  final String? socialSecurityNumber;
  @JsonKey(name: "EmployerTIN")
  final String? employerTIN;

  @JsonKey(name: "SignatureId")
  final String? signatureId;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  SetFatcaW9RequestEntity(
      {this.namePerIncomeTaxReturn,
      this.businessName,
      this.uSAddress,
      this.countryCode,
      this.stateId,
      this.cityId,
      this.postCode,
      this.accountNumberList,
      this.exemptPayeeCode,
      this.exemptFromFatcaReportingCode,
      this.isAdditionalRequester,
      this.requesterName,
      this.requesterUSAddress,
      this.requesterCountryCode,
      this.requesterState,
      this.requesterCity,
      this.requesterPostCode,
      this.taxPayer,
      this.socialSecurityNumber,
      this.employerTIN,
      this.signatureId,
      this.getToken,
      this.baseData});

  factory SetFatcaW9RequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SetFatcaW9RequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SetFatcaW9RequestEntityToJson(this);
}
