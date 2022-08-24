class FatcaCrsInfo {
  final int? id;
  final int? companyId;
  final int? productId;
  final int? accountId;
  final String? userId;
  final bool? response1;
  final bool? response2;
  final bool? response3;
  final bool? response4;
  final bool? response5;
  final bool? isActive;
  final dynamic deactivatedDate;
  final dynamic signatureId;
  final String? relationshipWithPep;
  final String? relationshipWithPEPName;
  final String? relationshipWithPEPNameAr;
  final String? personName;
  final String? personRole;
  final dynamic? namePerIncomeTaxReturn;
  final dynamic? dob;
  final dynamic? citizenShipCountry;
  final dynamic? permanentResidenceAddress;
  final dynamic? country;
  final dynamic? city;
  final dynamic? state;
  final dynamic? postCode;
  final dynamic? differentMailingAddress;
  final dynamic? taxPayer;
  final dynamic? usTaxIdNo;
  final dynamic? claimTaxTreatBenefits;
  final dynamic? beneficialOwnerResident;
  final dynamic? usTaxpayerIdNoOwner;
  final dynamic? typeOfIncome;
  final dynamic? explanation;
  final dynamic? businessName;
  final dynamic? usAddress;
  final dynamic? accountNo;
  final dynamic? exemptPayeeCode;
  final dynamic? socialSecurityNo;
  final String? createBy;
  final DateTime? createTime;
  final String? createTerminal;
  final String? taxResidenceCountry;

  FatcaCrsInfo(
      {this.id,
      this.companyId,
      this.productId,
      this.accountId,
      this.userId,
      this.response1,
      this.response2,
      this.response3,
      this.response4,
      this.response5,
      this.relationshipWithPep,
      this.relationshipWithPEPName,
      this.relationshipWithPEPNameAr,
      this.personName,
      this.personRole,
      this.namePerIncomeTaxReturn,
      this.dob,
      this.citizenShipCountry,
      this.permanentResidenceAddress,
      this.country,
      this.city,
      this.state,
      this.postCode,
      this.differentMailingAddress,
      this.taxPayer,
      this.usTaxIdNo,
      this.claimTaxTreatBenefits,
      this.beneficialOwnerResident,
      this.usTaxpayerIdNoOwner,
      this.typeOfIncome,
      this.explanation,
      this.businessName,
      this.usAddress,
      this.accountNo,
      this.exemptPayeeCode,
      this.socialSecurityNo,
      this.createBy,
      this.createTime,
      this.createTerminal,
      this.taxResidenceCountry,
      this.isActive: false,
      this.signatureId,
      this.deactivatedDate});
}
