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
  final String? employerCityAr;
  final String? employerContact;
  final bool? additionalIncome;
  final DateTime? createdOn;
  final bool? isActive;
  final String businessTypeAr;
  final String employerCountryAr;
  final String employeeCityId;

  JobDetailContentInfo(
      {this.id= 0,
      this.userId= "",
      this.profession= "",
      this.mainSource= "",
      this.annualIncome= "",
      this.employeeName= "",
      this.employerCountry= "",
      this.employerCity= "",
      this.employerContact= "",
      this.additionalIncome= false,
      this.createdOn,
      this.isActive= false,
      this.businessType= "",
      this.occupation= "",
      this.businessSpecificType= "",
      this.businessTypeAr = '',
      this.employerCountryAr = '',
      this.employerCityAr = '',
      this.employeeCityId = ''});
}
