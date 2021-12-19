import 'package:json_annotation/json_annotation.dart';

part "save_profile_information_request.g.dart";

@JsonSerializable()
class SaveProfileInformationRequest {
  @JsonKey(name: "Married")
  final bool? married;
  @JsonKey(name: "SpecialPerson")
  final bool? specialPerson;
  @JsonKey(name: "EmploymentStatus")
  final String? employmentStatus;
  @JsonKey(name: "SpauseName")
  final String? spauseName;
  @JsonKey(name: "NatureSP")
  final String? natureSP;
  @JsonKey(name: "IsAdditionalNational")
  final bool? isAdditionalNational;
  @JsonKey(name: "IsEmployed")
  final bool? isEmployed;
  @JsonKey(name: "AdditionalNationality")
  final String? additionalNationality;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveProfileInformationRequest({this.married,
    this.specialPerson,
    this.employmentStatus: "",
    this.spauseName: "",
    this.natureSP: "",
    this.additionalNationality,
    this.isAdditionalNational,
    this.isEmployed,
    required this.baseData});

  factory SaveProfileInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveProfileInformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveProfileInformationRequestToJson(this);
}
