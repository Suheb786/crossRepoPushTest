class CountryResidenceInfo {
  final int? id;
  final String? userId;
  final String? residantCountry;
  final String? cityId;
  final String? stateId;
  final String? buildingName;
  final String? streetName;
  final String? area;
  final String? city;
  final String? perResidantCountry;
  final String? perCity;
  final DateTime? createdOn;
  final bool? isActive;
  final String? residentCountryName;
  final String? perResidentCountryName;
  final String? perResidentCityName;
  final String residentCountryNameAr;
  final String cityAr;
  final String perResidentCountryNameAr;
  final String perResidentCityNameAr;

  CountryResidenceInfo(
      {this.id,
      this.userId,
      this.residantCountry,
      this.cityId,
      this.stateId,
      this.streetName,
      this.buildingName,
      this.perResidantCountry,
      this.area,
      this.city,
      this.perCity,
      this.createdOn,
      this.isActive,
      this.perResidentCityName = "",
      this.perResidentCountryName = "",
      this.residentCountryName = "",
      this.cityAr = '',
      this.residentCountryNameAr = '',
      this.perResidentCityNameAr = '',
      this.perResidentCountryNameAr = ''});
}
