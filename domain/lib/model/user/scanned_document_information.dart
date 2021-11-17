class ScannedDocumentInformation {
  final String? idNumber;
  final String? type;
  final String? fullName;
  final String? firstName;
  final String? middleName;
  final String? familyName;
  final String? dob;
  final String? nationality;
  final String? doe;
  final String? gender;
  final String? motherName;
  final String? documentCode;
  final String? documentNumber;
  final String? issuer;
  final String? optionalData1;
  final String? optionalData2;
  final String? mrtDraw;
  final String? frontCardImage;
  final String? backCardImage;
  final String? personFaceImage;
  final bool? isimtfBlacklist;
  final double? scanPercentage;

  ScannedDocumentInformation(
      {this.idNumber,
      this.type,
      this.fullName,
      this.firstName,
      this.middleName,
      this.familyName,
      this.dob,
      this.nationality,
      this.doe,
      this.gender,
      this.motherName,
      this.documentCode,
      this.documentNumber,
      this.issuer,
      this.optionalData1,
      this.optionalData2,
      this.mrtDraw,
      this.frontCardImage,
      this.backCardImage,
      this.personFaceImage,
      this.isimtfBlacklist,
      this.scanPercentage});
}
