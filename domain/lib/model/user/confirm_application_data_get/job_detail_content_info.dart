class JobDetailContentInfo {
  final int? id;
  final String? userId;
  final String? profession;
  final String? occupation;
  final String? businessType;
  final String? businessSpecificType;
  final String? mainSource;
  final String? annualIncome;
  final String? employeeName;
  final String? employerCountry;
  final String? employerCity;
  final String? employerContact;
  final bool? additionalIncome;
  final DateTime? createdOn;
  final bool? isActive;

  JobDetailContentInfo(
      {this.id,
      this.userId,
      this.profession,
      this.mainSource,
      this.annualIncome,
      this.employeeName,
      this.employerCountry,
      this.employerCity,
      this.employerContact,
      this.additionalIncome,
      this.createdOn,
      this.isActive,
      this.businessType,
      this.occupation,
      this.businessSpecificType});
}
