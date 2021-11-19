import 'package:json_annotation/json_annotation.dart';

part "save_residence_information_request.g.dart";

@JsonSerializable()
class SaveResidenceInformationRequest {
  @JsonKey(name: "residantCountry")
  final String? residantCountry;
  @JsonKey(name: "homeAddress")
  final String? homeAddress;
  @JsonKey(name: "streetAddress")
  final String? streetAddress;
  @JsonKey(name: "perResidantCountry")
  final String? permanentResidantCountry;
  @JsonKey(name: "perHomeAddre")
  final String? permanentHomeAddre;
  @JsonKey(name: "perStreetAddress")
  final String? permanentStreetAddress;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveResidenceInformationRequest(
      {this.residantCountry:"",
      this.homeAddress:"",
      this.streetAddress:"",
      this.permanentResidantCountry:"",
      this.permanentHomeAddre:"",
      this.permanentStreetAddress:"",
      required this.baseData});

  factory SaveResidenceInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveResidenceInformationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveResidenceInformationRequestToJson(this);
}
