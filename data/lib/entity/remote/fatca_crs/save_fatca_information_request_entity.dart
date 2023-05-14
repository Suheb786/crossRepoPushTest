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
  @JsonKey(name: "TaxResidenceCountry")
  final String? taxResidenceCountry;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveFatcaInformationRequestEntity(
      {this.response1,
      this.response2,
      this.response3,
      this.response4,
      this.response5,
      this.taxResidenceCountry,
      required this.baseData,
      this.relationshipWithPEP,
      this.personName,
      this.personRole,
      this.getToken= true});

  factory SaveFatcaInformationRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveFatcaInformationRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveFatcaInformationRequestEntityToJson(this);
}
