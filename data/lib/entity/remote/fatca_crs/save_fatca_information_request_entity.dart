import 'package:json_annotation/json_annotation.dart';

part "save_fatca_information_request_entity.g.dart";

@JsonSerializable()
class SaveFatcaInformationRequestEntity {
  @JsonKey(name: "Response1")
  final bool? response1;
  @JsonKey(name: "Response2")
  final bool? response2;
  @JsonKey(name: "Response3")
  final bool? response3;
  @JsonKey(name: "Response4")
  final bool? response4;
  @JsonKey(name: "Response5")
  final bool? response5;
  @JsonKey(name: "RelationshipWithPEP")
  final String? relationshipWithPEP;
  @JsonKey(name: "PersonName")
  final String? personName;
  @JsonKey(name: "PersonRole")
  final String? personRole;
  @JsonKey(name: "IsTinNoRes4")
  final bool? isTinNoRes4;
  @JsonKey(name: "TaxResidenceCountry")
  final String? taxResidenceCountry;
  @JsonKey(name: "TinNoRes4")
  final String? tinNoRes4;
  @JsonKey(name: "ReasonUnavailbleRes4")
  final String? reasonUnavailableRes4;
  @JsonKey(name: "ReasonBRes4")
  final String? reasonBRes4;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveFatcaInformationRequestEntity({this.response1,
    this.response2,
    this.response3,
    this.response4,
    this.response5,
    this.isTinNoRes4,
    this.taxResidenceCountry,
    this.tinNoRes4,
    this.reasonUnavailableRes4,
    this.reasonBRes4,
    required this.baseData,
    this.relationshipWithPEP,
    this.personName,
    this.personRole,
    this.getToken: true});

  factory SaveFatcaInformationRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$SaveFatcaInformationRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveFatcaInformationRequestEntityToJson(this);
}
