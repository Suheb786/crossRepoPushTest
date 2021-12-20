class Beneficiary {
  final String? beneficiaryId;
  final dynamic? imageUrl;
  final String? nickName;
  final String? fullName;
  final String? iban;
  final String? accountHolderName;
  final String? bankName;
  final String? purpose;
  final String? purposeDetails;

  Beneficiary(
      {this.beneficiaryId: "",
      this.imageUrl: "",
      this.nickName: "",
      this.fullName: "",
      this.bankName,
      this.iban: "",
      this.accountHolderName: "",
      this.purpose: "",
      this.purposeDetails: ""});
}
