class ScannedDocumentInformation {
  String? idNumber;
  String? type;
  String? fullName;
  String? firstName;
  String? middleName;
  String? familyName;
  DateTime? dob;
  String? nationality;
  DateTime? doe;
  DateTime? issuingDate;
  String? issuingPlace;
  String? gender;
  String? motherName;
  String? documentCode;
  String? documentNumber;
  String? issuer;
  String? optionalData1;
  String? optionalData2;
  String? mrtDraw;
  String? frontCardImage;
  String? backCardImage;
  String? personFaceImage;
  bool? isimtfBlacklist;
  num? scanPercentage;
  String instanceId;
  String? secondNameEn;
  String? thirdNameEn;
  String? placeOfBirth;
  String? familyNameAr;
  String? secNameAr;
  String? thirdNameAr;
  String? firstNameAr;
  String? issuingPlaceISo3;
  final String? nationalityIsoCode3;
  String? currentIssuingPlace;

  ScannedDocumentInformation(
      {this.type = "",
      this.fullName = "",
      this.firstName = "",
      this.middleName = "",
      this.familyName = "",
      this.idNumber = "",
      this.dob,
      this.nationality = "",
      this.doe,
      this.gender = "",
      this.motherName = "",
      this.documentCode = "",
      this.documentNumber = "",
      this.issuer = "",
      this.optionalData1 = "",
      this.optionalData2 = "",
      this.mrtDraw = "",
      this.frontCardImage = "",
      this.backCardImage = "",
      this.personFaceImage = "",
      this.isimtfBlacklist = false,
      this.instanceId = "",
      this.scanPercentage = 0,
      this.issuingPlace = "",
      this.issuingDate,
      this.nationalityIsoCode3 = "",
      this.secondNameEn = "",
      this.placeOfBirth = "",
      this.familyNameAr = "",
      this.secNameAr = "",
      this.thirdNameEn = "",
      this.firstNameAr = "",
      this.thirdNameAr = "",
      this.issuingPlaceISo3 = "",
      this.currentIssuingPlace = ""});
}
