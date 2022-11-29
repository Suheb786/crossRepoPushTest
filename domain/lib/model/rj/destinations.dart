class Destinations {
  final String? name;
  final String? code;
  final String? countryName;
  final String? cityName;
  final String? airportName;
  bool isSelected;

  Destinations(
      {this.name, this.code, this.countryName, this.cityName, this.airportName, this.isSelected = false});
}
