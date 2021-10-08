class Country {
  final String? countryName;
  final String? countryFlag;
  final String? countryCode;
  final String? countryCallingCode;
  bool isSelected;

  Country(
      {this.countryName: "",
      this.countryFlag: "",
      this.countryCode: "",
      this.countryCallingCode: "",
      this.isSelected: false});
}
