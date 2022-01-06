class StateCityData {
  StateCityData(
      {this.createTime,
      this.countryId: "",
      this.stateId: "",
      this.stateName: "",
      this.cityName: "",
      this.cityId: "",
      this.isSelected: false});

  DateTime? createTime;
  String? countryId;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  bool isSelected;
}
