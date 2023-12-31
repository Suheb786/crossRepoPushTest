class Beneficiary {
  final String? id;
  final String? userId;

  //final String? beneficiaryId;
  dynamic imageUrl;
  final String? nickName;
  final String? fullName;
  final String? accountNo;
  final String? mobileNumber;
  final String? beneficiaryAddress;
  final String? iban;
  final String? accountHolderName;
  final String? bankName;
  final String? purpose;
  final String? purposeDetails;
  final String? beneType;
  final String? purposeType;
  final String? detCustomerType;
  final String? purposeParent;
  final String? purposeParentDetails;
  final num? limit;
  final String? identifier;

  Beneficiary(
      {this.id = "",
      this.userId = "",
      this.imageUrl = "",
      this.nickName = "",
      this.fullName = "",
      this.bankName,
      this.iban = "",
      this.purposeParent,
      this.purposeParentDetails,
      this.limit,
      this.accountHolderName = "",
      this.purpose = "",
      this.purposeDetails = "",
      this.mobileNumber = "",
      this.accountNo = "",
      this.beneficiaryAddress = "",
      this.detCustomerType = "",
      this.purposeType = "",
      this.beneType,
      this.identifier = ''});
}
