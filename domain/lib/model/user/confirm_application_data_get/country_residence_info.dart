class CountryResidenceInfo {
  final int? id;
  final String? userId;
  final String? residantCountry;
  final String? homeAddress;
  final String? streetAddress;
  final String? perResidantCountry;
  final dynamic? perHomeAddress;
  final dynamic? perStreetAddress;
  final DateTime? createdOn;
  final bool? isActive;

  CountryResidenceInfo({
    this.id,
    this.userId,
    this.residantCountry,
    this.homeAddress,
    this.streetAddress,
    this.perResidantCountry,
    this.perHomeAddress,
    this.perStreetAddress,
    this.createdOn,
    this.isActive,
  });
}
