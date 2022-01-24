class FatcaW9Data {
  FatcaW9Data({
    this.signatureId,
    this.namePerIncomeTaxReturn,
    this.businessName,
    this.usAddress,
    this.city,
    this.state,
    this.postCode,
    this.accountNumberList,
    this.exemptPayeeCode,
    this.exemptFromFatcaReportingCode,
    this.additionalRequester,
    this.requesterName,
    this.requesterUsAddress,
    this.requesterCity,
    this.requesterState,
    this.requesterPostCode,
    this.taxPayer,
    this.socialSecurityNumber,
    this.employerTin,
  });

  String? signatureId;
  String? namePerIncomeTaxReturn;
  String? businessName;
  String? usAddress;
  String? city;
  String? state;
  String? postCode;
  String? accountNumberList;
  String? exemptPayeeCode;
  String? exemptFromFatcaReportingCode;
  bool? additionalRequester;
  String? requesterName;
  String? requesterUsAddress;
  String? requesterCity;
  String? requesterState;
  String? requesterPostCode;
  String? taxPayer;
  String? socialSecurityNumber;
  String? employerTin;
}
