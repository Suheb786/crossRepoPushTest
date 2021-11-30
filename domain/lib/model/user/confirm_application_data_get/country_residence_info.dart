class CountryResidenceInfo {
  final int? id;
  final String? userId;
  final String? residantCountry;
  final String? buildingName;
  final String? streetName;
  final String? district;
  final String? city;
  final String? perResidantCountry;
  final String? perCity;
  final DateTime? createdOn;
  final bool? isActive;

  CountryResidenceInfo({
    this.id,
    this.userId,
    this.residantCountry,
    this.streetName,
    this.buildingName,
    this.perResidantCountry,
    this.district,
    this.city,
    this.perCity,
    this.createdOn,
    this.isActive,
  });
}
