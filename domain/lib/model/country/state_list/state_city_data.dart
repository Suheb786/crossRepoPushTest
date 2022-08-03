class StateCityData {
  StateCityData(
      {this.createTime,
      this.countryId: "",
      this.stateId: "",
      this.stateName: "",
      this.cityName: "",
      this.cityId: "",
      this.isSelected: false,
      this.cityNameAR: "",
      this.stateNameAR: ""});

  DateTime? createTime;
  String? countryId;
  String? stateId;
  String? stateName;
  String? stateNameAR;
  String? cityId;
  String? cityName;
  String? cityNameAR;
  bool isSelected;
}
