import 'package:json_annotation/json_annotation.dart';

part "save_residence_information_request.g.dart";

@JsonSerializable()
class SaveResidenceInformationRequest {
  @JsonKey(name: "residantCountry")
  final String? residantCountry;
  @JsonKey(name: "BuildingName")
  final String? buildingName;
  @JsonKey(name: "StreetName")
  final String? streetName;
  @JsonKey(name: "Area")
  final String? area;
  @JsonKey(name: "cityID")
  final String? cityId;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "PerCountry")
  final String? perCountry;
  @JsonKey(name: "PerCity")
  final String? perCity;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveResidenceInformationRequest(
      {this.residantCountry: "",
      this.buildingName: "",
      this.streetName: "",
      this.area: "",
      this.cityId: "",
      this.stateID: "",
      this.perCountry: "",
      this.perCity: "",
      required this.baseData});

  factory SaveResidenceInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveResidenceInformationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveResidenceInformationRequestToJson(this);
}
