class Beneficiary {
  final String? beneficiaryId;
  final String? imageUrl;
  final String? name;
  final String? iban;
  final String? accountHolderName;
  final String? bankName;
  final String? purpose;
  final String? purposeDetails;

  Beneficiary(
      {this.beneficiaryId: "",
      this.imageUrl: "",
      this.name: "",
      this.bankName,
      this.iban: "",
      this.accountHolderName: "",
      this.purpose: "",
      this.purposeDetails: ""});
}
